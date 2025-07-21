return {
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
      discovery = {
        enabled = false,
      },
      adapters = {
        require 'neotest-jest' {
          jestCommand = 'npm t --',
          jest_test_discovery = false,
          -- jestConfigFile = 'custom.jest.config.ts',
          -- env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
    }

    vim.keymap.set('n', '<leader>jsr', neotest.run.run, { desc = 'Single test Run' })
    vim.keymap.set('n', '<leader>jsd', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Single test debug' })
    vim.keymap.set('n', '<leader>jfr', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'File test Run' })
    vim.keymap.set('n', '<leader>jfd', function()
      neotest.run.run {
        vim.fn.expand '%',
        strategy = 'dap',
      }
    end, { desc = 'File test debug' })
    vim.keymap.set('n', '<leader>jo', function()
      neotest.output.open { enter = true }
    end, { desc = 'Open test result output' })
    vim.keymap.set('n', '<leader>jp', neotest.output_panel.toggle, { desc = 'Toggle test result output tree' })
    vim.keymap.set('n', '<leader>jr', neotest.summary.toggle, { desc = 'Toggle test summary' })
  end,
}
