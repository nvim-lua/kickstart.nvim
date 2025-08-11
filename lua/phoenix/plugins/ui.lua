-- UI related plugins, mostly fancy stuff
return {
  -- Better `vim.notify()`
  -- {
  --   'rcarriga/nvim-notify',
  --   keys = {
  --     {
  --       '<leader>un',
  --       function()
  --         require('notify').dismiss { silent = true, pending = true }
  --       end,
  --       desc = 'Dismiss all Notifications',
  --     },
  --   },
  --   opts = {
  --     timeout = 3000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.75)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.75)
  --     end,
  --   },
  -- },

  -- better vim.ui
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {
        input = {
          enabled = true,
        },
        select = {
          enabled = true,
          backend = { 'telescope', 'builtin' },
          telescope = require('telescope.themes').get_cursor(),
        },
      }
    end,
  },

  -- noicer ui
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     cmdline = {
  --       enabled = true,
  --     },
  --     lsp = {
  --       override = {
  --         ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
  --         ['vim.lsp.util.stylize_markdown'] = true,
  --         ['cmp.entry.get_documentation'] = true,
  --       },
  --     },
  --     routes = {
  --       {
  --         filter = {
  --           event = 'msg_show',
  --           find = '%d+L, %d+B',
  --         },
  --         view = 'mini',
  --       },
  --     },
  --     presets = {
  --       bottom_search = true,
  --       -- command_palette = true,
  --       long_message_to_split = true,
  --       inc_rename = true,
  --     },
  --   },
  --   keys = {
  --     {
  --       '<S-Enter>',
  --       function()
  --         require('noice').redirect(vim.fn.getcmdline())
  --       end,
  --       mode = 'c',
  --       desc = 'Redirect Cmdline',
  --     },
  --     {
  --       '<leader>snl',
  --       function()
  --         require('noice').cmd 'last'
  --       end,
  --       desc = 'Noice Last Message',
  --     },
  --     {
  --       '<leader>snh',
  --       function()
  --         require('noice').cmd 'history'
  --       end,
  --       desc = 'Noice History',
  --     },
  --     {
  --       '<leader>sna',
  --       function()
  --         require('noice').cmd 'all'
  --       end,
  --       desc = 'Noice All',
  --     },
  --     {
  --       '<leader>snd',
  --       function()
  --         require('noice').cmd 'dismiss'
  --       end,
  --       desc = 'Dismiss All',
  --     },
  --     {
  --       '<c-f>',
  --       function()
  --         if not require('noice.lsp').scroll(4) then
  --           return '<c-f>'
  --         end
  --       end,
  --       silent = true,
  --       expr = true,
  --       desc = 'Scroll forward',
  --       mode = { 'i', 'n', 's' },
  --     },
  --     {
  --       '<c-b>',
  --       function()
  --         if not require('noice.lsp').scroll(-4) then
  --           return '<c-b>'
  --         end
  --       end,
  --       silent = true,
  --       expr = true,
  --       desc = 'Scroll backward',
  --       mode = { 'i', 'n', 's' },
  --     },
  --   },
  -- },
}
