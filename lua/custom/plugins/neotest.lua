return {
  {
    'rcasia/neotest-java',
    ft = 'java',
    dependencies = {
      'nvim-neotest/neotest',
      dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
      },
    },
    config = function()
      local neotest = require 'neotest'

      neotest.setup {
        adapters = {
          require 'neotest-java' {
            ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
          },
        },
      }

      vim.keymap.set('n', '<leader>tr', neotest.run.run, { desc = '[T]est [R]un', noremap = true })
      vim.keymap.set('n', '<leader>ts', neotest.run.stop, { desc = '[T]est [S]top', noremap = true })
      vim.keymap.set('n', '<leader>ta', neotest.run.attach, { desc = '[T]est [A]ttach', noremap = true })

      vim.keymap.set('n', '<leader>to', neotest.output.open, { desc = '[T]est output [O]pen', noremap = true })
    end,
  },
}
