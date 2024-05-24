return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'folke/noice.nvim' },
    },
    config = function()
      local noice = require 'noice'

      require('lualine').setup {
        options = {
          theme = 'catppuccin',
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = '' },
              fmt = function(_, context)
                local winnr = vim.fn.tabpagewinnr(context.tabnr)
                local ok, val = pcall(vim.api.nvim_win_get_var, winnr, 'nnn')
                if ok and val then
                  return 'nnn'
                end
              end,
              color = function(section)
                local winnr = vim.api.nvim_get_current_win()
                local ok, val = pcall(vim.api.nvim_win_get_var, winnr, 'nnn')
                if ok and val then
                  return { fg = '#054fca' }
                end
                return {}
              end,
            },
          },
          lualine_x = {
            {
              noice.api.status.message.get_hl,
              cond = noice.api.status.message.has,
            },
            {
              noice.api.status.command.get_hl,
              cond = noice.api.status.command.has,
              color = { fg = '#ff0000' },
            },
            {
              noice.api.status.mode.get,
              cond = noice.api.status.mode.has,
              color = { fg = '#00ff00' },
            },
          },
          lualine_z = {
            {
              'location',
              separator = { right = '' },
              left_padding = 2,
            },
          },
        },
        extensions = {
          'oil',
          'lazy',
        },
      }

      --      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      --        callback = function(ev)
      --          local filetype = vim.api.nvim_get_option_value('filetype', { buf = ev.buf })
      --
      --          print(string.format('event fired: %s', filetype))
      --          if filetype == 'oil' then
      --            local ok, value = pcall(vim.api.nvim_buf_get_var, ev.buf, 'nnn')
      --            if not ok then
      --              vim.api.nvim_buf_set_var(ev.buf, 'nnn', true)
      --            end
      --          end
      --        end,
      --      })
    end,
  },
}
