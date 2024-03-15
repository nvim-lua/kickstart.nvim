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
  vim.keymap.set('n', '<leader>te', ':Neotest summary toggle<CR>', { desc = '[T]est [E]xplorer' }),
  vim.keymap.set('n', '<leader>rts', ':Neotest run suite=true<CR>', { desc = '[R]un [T]est [S]uite' }),
  vim.keymap.set('n', '<leader>rtc', ':Neotest run suite=true<CR>', { desc = '[R]un [T]est [C]ase' }),
}
