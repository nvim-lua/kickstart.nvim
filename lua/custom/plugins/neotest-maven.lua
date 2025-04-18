return {
  {
    'lucas-garcia-rubio/neotest-maven',
    -- dir = '~/Repositories/pessoal/plugins/neotest-maven',
    name = 'neotest-maven',
    ft = 'java',
    dependencies = {
      'mfussenegger/nvim-jdtls',
      'mfussenegger/nvim-dap', -- for the debugger
      'rcarriga/nvim-dap-ui', -- recommended
      'theHamsta/nvim-dap-virtual-text', -- recommended
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local function neotest_output_and_switch()
        require('neotest').output.open { enter = true }
      end

      -- Set key mapping for the function
      vim.keymap.set('n', '<leader>lw', neotest_output_and_switch, { desc = 'Neotest output and enter its window' })
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'neotest-maven',
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-maven',
        },
      }
    end,
  },
}
