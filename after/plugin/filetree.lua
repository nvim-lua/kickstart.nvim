vim.keymap.set('n', '<leader>ef',
    ':Neotree source=filesystem reveal=true toggle<cr>',
    { desc = '[E]xplore [F]iles (tree)' }
)
vim.keymap.set('n', '<leader>eb',
    ':Neotree source=buffers reveal=true toggle<cr>',
    { desc = '[E]xplore [B]uffers (tree)' }
)
