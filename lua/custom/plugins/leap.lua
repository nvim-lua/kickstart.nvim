-- https://github.com/ggandor/leap.nvim
return {
  'ggandor/leap.nvim',
  dependencies = {
    'tpope/vim-repeat',
  },
  opts = {},
  config = function(_, opts)
    require('leap').setup(opts)
    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>l', '<Plug>(leap-forward)', { noremap = true, silent = true, desc = '[L]eap forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>L', '<Plug>(leap-backward)', { noremap = true, silent = true, desc = '[L]eap backward' })
    -- vim.keymap.set({ 'n', 'x', 'o' }, '<leader>gs', '<Plug>(leap-from-window)')
  end,
}
