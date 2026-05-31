return {
  'Civitasv/cmake-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'c', 'cpp' },
  keys = {
    { '<leader>cmg', '<cmd>CMakeGenerate<CR>', desc = '[C]Make [G]enerate' },
    { '<leader>cmb', '<cmd>CMakeBuild<CR>', desc = '[C]Make [B]uild' },
    { '<leader>cmr', '<cmd>CMakeRun<CR>', desc = '[C]Make [R]un' },
    { '<leader>cmd', '<cmd>CMakeDebug<CR>', desc = '[C]Make [D]ebug' },
    { '<leader>cms', '<cmd>CMakeStop<CR>', desc = '[C]Make [S]top' },
  },
  opts = {},
}
