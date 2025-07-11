local M = {}
local utils = require('nvim-claude.utils')

-- Update Claude settings with current Neovim server address
function M.update_claude_settings()
  local project_root = utils.get_project_root()
  if not project_root then
    return
  end
  
  local settings_path = project_root .. '/.claude/settings.json'
  local settings_dir = project_root .. '/.claude'
  
  -- Get current Neovim server address
  local server_addr = vim.v.servername
  if not server_addr or server_addr == '' then
    -- If no servername, we can't communicate
    return
  end
  
  -- Ensure .claude directory exists
  if vim.fn.isdirectory(settings_dir) == 0 then
    vim.fn.mkdir(settings_dir, 'p')
  end
  
  -- Read existing settings or create new
  local settings = {}
  if vim.fn.filereadable(settings_path) == 1 then
    local ok, content = pcall(vim.fn.readfile, settings_path)
    if ok and #content > 0 then
      local decode_ok, decoded = pcall(vim.json.decode, table.concat(content, '\n'))
      if decode_ok then
        settings = decoded
      end
    end
  end
  
  -- Ensure hooks structure exists
  if not settings.hooks then
    settings.hooks = {}
  end
  if not settings.hooks.PreToolUse then
    settings.hooks.PreToolUse = {}
  end
  if not settings.hooks.PostToolUse then
    settings.hooks.PostToolUse = {}
  end
  
  -- Update hook commands with current server address
  local pre_hook_cmd = string.format(
    'nvr --servername "%s" --remote-expr \'luaeval("require(\\"nvim-claude.hooks\\").pre_tool_use_hook()")\'',
    server_addr
  )
  
  local post_hook_cmd = string.format(
    'nvr --servername "%s" --remote-send "<C-\\\\><C-N>:lua require(\'nvim-claude.hooks\').post_tool_use_hook()<CR>"',
    server_addr
  )
  
  -- Update PreToolUse hooks
  local pre_hook_found = false
  for _, hook_group in ipairs(settings.hooks.PreToolUse) do
    if hook_group.matcher == "Edit|Write|MultiEdit" then
      hook_group.hooks = {{type = "command", command = pre_hook_cmd}}
      pre_hook_found = true
      break
    end
  end
  
  if not pre_hook_found then
    table.insert(settings.hooks.PreToolUse, {
      matcher = "Edit|Write|MultiEdit",
      hooks = {{type = "command", command = pre_hook_cmd}}
    })
  end
  
  -- Update PostToolUse hooks
  local post_hook_found = false
  for _, hook_group in ipairs(settings.hooks.PostToolUse) do
    if hook_group.matcher == "Edit|Write|MultiEdit" then
      hook_group.hooks = {{type = "command", command = post_hook_cmd}}
      post_hook_found = true
      break
    end
  end
  
  if not post_hook_found then
    table.insert(settings.hooks.PostToolUse, {
      matcher = "Edit|Write|MultiEdit",
      hooks = {{type = "command", command = post_hook_cmd}}
    })
  end
  
  -- Write updated settings
  local encoded = vim.json.encode(settings)
  vim.fn.writefile({encoded}, settings_path)
end

-- Setup autocmds to update settings
function M.setup()
  vim.api.nvim_create_autocmd({"VimEnter", "DirChanged"}, {
    group = vim.api.nvim_create_augroup("NvimClaudeSettingsUpdater", { clear = true }),
    callback = function()
      -- Defer to ensure servername is available
      vim.defer_fn(function()
        M.update_claude_settings()
      end, 100)
    end,
  })
end

return M