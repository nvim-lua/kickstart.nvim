return {
  {
    'tzachar/highlight-undo.nvim',
    config = function()
      vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
        callback = function()
          vim.highlight.on_yank { timeout = 200 }
        end,
      })

      vim.api.nvim_set_hl(0, 'highlight-action', {
        fg = '#dcd7ba',
        bg = '#2d4f67',
        default = true,
      })

      require('highlight-undo').setup {
        duration = 200,
        undo = {
          lhs = 'u',
          hlgroup = 'DiffAdd',
          map = 'undo',
          opts = {},
        },
        redo = {
          lhs = '<C-r>',
          hlgroup = 'DiffAdd',
          map = 'redo',
          opts = {},
        },
      }
    end,
  },
}
