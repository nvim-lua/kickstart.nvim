-- Custom Statusline Configuration
local M = {}

function M.setup()
  -- Get reference to mini.statusline
  local statusline = require('mini.statusline')
  local mode_manager = require('custom.plugins.mode_manager')

  -- Store the original section_location function
  local original_location = statusline.section_location

  -- Create function to get mode-specific content
  local function get_mode_content()
    local mode = mode_manager.get_mode()
    local settings = mode_manager.setting(mode:lower(), 'status_info') or {}
    
    local parts = {
      mode = string.format('[%s]', mode),
      info = settings.text or '',
      icon = settings.icon or ''
    }
    
    if parts.icon ~= '' and parts.info ~= '' then
      return string.format('%s %s %s', parts.mode, parts.icon, parts.info)
    elseif parts.info ~= '' then
      return string.format('%s %s', parts.mode, parts.info)
    else
      return parts.mode
    end
  end

  -- Override section_location to include enhanced mode indicator
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    local color = mode_manager.get_mode_highlight()
    
    -- Create highlight groups for mode indicator
    vim.api.nvim_set_hl(0, 'ModeIndicator', {
      fg = color,
      bold = true
    })
    vim.api.nvim_set_hl(0, 'ModeIndicatorBg', {
      bg = color,
      fg = '#000000',
      bold = true
    })
    
    -- Get mode-specific content
    local mode_content = get_mode_content()
    
    -- Format: MODE LINE:COL with custom highlighting
    return string.format(
      '%%#ModeIndicator#%s%%#StatusLine# %s',
      mode_content,
      original_location()
    )
  end

  -- Helper function to update mode-specific status info
  local function update_mode_status(mode, info)
    if type(info) == 'string' then
      info = { text = info }
    end
    mode_manager.setting(mode:lower(), 'status_info', info)
  end

  -- Register callback for mode changes to update statusline
  mode_manager.register_post_hook(function(new_mode)
    -- Example of setting mode-specific status info
    if new_mode == 'plan' then
      update_mode_status('plan', {
        text = 'Planning Mode',
        icon = '󰐉' -- Requires Nerd Font
      })
    else
      update_mode_status('act', {
        text = 'Action Mode',
        icon = '󰐊' -- Requires Nerd Font
      })
    end
    
    vim.cmd('redrawstatus')
  end)

  -- Set up status line with icons if using nerd font
  statusline.setup({
    use_icons = vim.g.have_nerd_font,
    content = {
      active = function()
        local mode = mode_manager.get_mode()
        local mode_info = mode_manager.setting(mode:lower(), 'status_info') or {}
        
        -- Add mode-specific content to status line sections
        return {
          '%#ModeIndicator#' .. get_mode_content() .. '%#StatusLine#',
          statusline.section_filename(),
          statusline.section_modified(),
          '%=', -- Right align
          mode_info.extra or '',
          statusline.section_searchcount(),
          statusline.section_location(),
        }
      end
    }
  })

  -- Create autocommand for ModeChanged event
  vim.api.nvim_create_autocmd('User', {
    pattern = 'ModeChanged',
    callback = function(args)
      if args.data then
        local old_mode = args.data.old_mode
        local new_mode = args.data.new_mode
        
        -- Trigger any mode-specific status line updates
        vim.schedule(function()
          -- Allow for async status updates
          vim.cmd('redrawstatus')
        end)
      end
    end,
  })
  
  -- Expose update_mode_status function
  M.update_mode_status = update_mode_status
end

return M