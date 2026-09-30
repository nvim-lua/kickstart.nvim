vim.pack.add {
  { src = 'https://github.com/tpope/vim-fugitive', name = 'fugitive' },
}

vim.keymap.set('n', '<leader>gvd', ':Gvdiffsplit<CR>', { desc = '[G]it [V]iew [D]iff', noremap = true, silent = true })
