return {
  'stevearc/overseer.nvim',
  opts = {
    templates = { "builtin", "user.run_script" },
  },
  vim.keymap.set('n', '<space>or', '<Cmd>OverseerRun<CR>'),
  vim.keymap.set('n', '<C-O>', '<Cmd>OverseerToggle<CR>'),
}
