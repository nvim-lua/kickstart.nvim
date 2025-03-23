return {
  {
    dir = '~/Repositories/pessoal/plugins/neotest-maven',
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
