-- Map <Leader>nt to toggle nvim-tree
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Map <C-p> to switch focus between nvim-tree and code
vim.api.nvim_set_keymap('n', '<C-f>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

-- Map 'a' to create a new file
vim.api.nvim_set_keymap('n', 'a', ':NvimTreeNewFile<CR>', { noremap = true, silent = true })

-- Map <Leader>nd to delete selected file/directory
vim.api.nvim_set_keymap('n', 'C-d', ':NvimTreeDelete<CR>', { noremap = true, silent = true })

-- Map <Leader>nr to rename selected file/directory
vim.api.nvim_set_keymap('n', 'r', ':NvimTreeRename<CR>', { noremap = true, silent = true })
