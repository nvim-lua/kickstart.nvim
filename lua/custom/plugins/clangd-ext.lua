return {
  {
    'p00f/clangd_extensions.nvim',
    lazy = true,
    config = function()
      require('clangd_extensions').setup {
        inlay_hints = {
          inline = vim.fn.has 'nvim-0.10' == 1,
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refresh of the inlay hints
          only_current_line_autocmd = 'CursorHold',
          -- Show parameter hints with the inlay hints
          show_parameter_hints = true,
          -- Show hints at the beginning of the line
          show_variable_name = false,
          -- Prefix for parameter hints
          parameter_hints_prefix = '<- ',
          -- Prefix for all the other hints (type, chaining)
          other_hints_prefix = '=> ',
        },
      }
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
