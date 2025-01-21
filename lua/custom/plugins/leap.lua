return {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)', { noremap = true, silent = true })
  end,
}
