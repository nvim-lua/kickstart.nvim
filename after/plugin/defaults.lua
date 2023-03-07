vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set({ 'n', 'v' }, '<leader>cd', ':cd %:h<CR>', { noremap = true, desc = 'Change Directory to Current' })
