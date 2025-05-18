return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
    },
    config = function()
      local neotest = require 'neotest'

      neotest.setup {
        adapters = {
          require 'neotest-jest',
        },
      }

      -- Set up keybindings
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map('n', '<leader>tt', function()
        neotest.run.run()
      end, opts) -- Run nearest test
      map('n', '<leader>tf', function()
        neotest.run.run(vim.fn.expand '%')
      end, opts) -- Run current file
      map('n', '<leader>td', function()
        neotest.run.run { strategy = 'dap' }
      end, opts) -- Run with debugger
      map('n', '<leader>to', function()
        neotest.output.open()
      end, opts)
    end,
  },
}
