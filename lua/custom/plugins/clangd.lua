return {
  { 'p00f/clangd_extensions.nvim', lazy = true },
  {
    'Civitasv/cmake-tools.nvim',
    lazy = true,
    ft = { 'cpp' },
    opts = {},
    keys = {
      { '<leader>db', "<cmd> CMakeDebug <cr>", desc = "CMake debug" }
    }
  },
}
