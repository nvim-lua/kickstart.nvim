return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-dotnet' {
          dap = { justMyCode = false },
        },
        require 'neotest-plenary',
      },
    }
  end,
  vim.keymap.set('n', 'ts', ':Neotest run suite=true<CR> :Neotest summary open<CR>', {}),
}
