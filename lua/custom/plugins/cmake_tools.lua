return {
  'Civitasv/cmake-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = {
    'CMakeGenerate',
    'CMakeBuild',
    'CMakeRun',
    'CMakeTest',
    'CMakeSelectBuildType',
    'CMakeSelectBuildTarget',
  },
  ft = { 'cmake' },
  keys = {
    { '<leader>cg', '<cmd>CMakeGenerate<CR>', desc = '[C]Make [G]enerate' },
    { '<leader>cb', '<cmd>CMakeBuild<CR>', desc = '[C]Make [B]uild' },
    { '<leader>cr', '<cmd>CMakeRun<CR>', desc = '[C]Make [R]un' },
    { '<leader>ct', '<cmd>CMakeTest<CR>', desc = '[C]Make [T]est' },
    { '<leader>cc', '<cmd>CMakeSelectBuildType<CR>', desc = '[C]Make [C]onfiguration' },
  },
  opts = {
    cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' },
    cmake_executor = {
      name = 'quickfix',
    },
    cmake_runner = {
      name = 'terminal',
    },
  },
}
