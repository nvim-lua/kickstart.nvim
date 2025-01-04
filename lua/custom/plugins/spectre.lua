return {
  {
    'nvim-pack/nvim-spectre',
    lazy = true,
    cmd = { 'Spectre' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'catppuccin/nvim',
    },
    keys = {
      {
        '<leader>S',
        function()
          require('spectre').toggle()
        end,
        desc = 'Toggle Spectre',
      },
      {
        '<leader>SW',
        function()
          require('spectre').open_visual { select_word = true }
        end,
        mode = 'n',
        desc = 'Search current word',
      },
      {
        '<leader>SW',
        function()
          require('spectre').open_visual()
        end,
        mode = 'v',
        desc = 'Search current word',
      },
      {
        '<leader>SP',
        function()
          require('spectre').open_file_search { select_word = true }
        end,
        desc = 'Search on current file',
      },
    },
    config = function()
      local theme = require('catppuccin.palettes').get_palette 'macchiato'
      vim.api.nvim_set_hl(0, 'SpectreSearch', { bg = theme.red, fg = theme.base })
      vim.api.nvim_set_hl(0, 'SpectreReplace', { bg = theme.green, fg = theme.base })
      require('spectre').setup {
        highlight = {
          search = 'SpectreSearch',
          replace = 'SpectreReplace',
        },
        mapping = {
          ['send_to_qf'] = {
            map = '<C-q>',
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = 'send all items to quickfix',
          },
        },
        replace_engine = {
          sed = {
            cmd = 'sed',
            args = {
              '-i',
              '',
              '-E',
            },
          },
        },
      }
    end,
  }
}
