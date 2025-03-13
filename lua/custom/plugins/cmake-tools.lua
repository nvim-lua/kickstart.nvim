return {
  'Civitasv/cmake-tools.nvim',
  config = function()
    require('cmake-tools').setup {}

    vim.keymap.set('n', '<leader>mb', ':CMakeBuild<CR>')
    vim.keymap.set('n', '<leader>mr', ':CMakeRun<CR>')

    vim.keymap.set('n', '<leader>mmb', ':CMakeBuildCurrentFile<CR>')
    vim.keymap.set('n', '<leader>mmr', ':CMakeRunCurrentFile<CR>')
  end,
}
