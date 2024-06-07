return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'folke/noice.nvim' },
      { 'arkav/lualine-lsp-progress' },
    },
    config = function()
      local colors = {
        gray = '#6c7086',
        purple = '#cba6f7',
      }

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
              fmt = function(_, _)
                -- local winnr = vim.fn.tab (context.tabnr)
                -- vim.fn.winbufnr(winnr)
                local val = require('fancyutil').get_oil_nnn()
                if val then
                  return 'nnn'
                end
              end,
              color = function(_)
                local val = require('fancyutil').get_oil_nnn()
                if val == true then
                  return { fg = '#054fca' }
                end
                return {}
              end,
            },
          },
          lualine_x = {
            {
              'lsp_progress',
              display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' } },
              colors = {
                percentage = colors.gray,
                title = colors.gray,
                message = colors.gray,
                spinner = colors.gray,
                lsp_client_name = colors.purple,
                use = true,
              },
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
