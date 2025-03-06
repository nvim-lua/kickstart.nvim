-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, { command = 'checktime' })

vim.api.nvim_create_user_command('DeleteOtherBuffers', function()
  require('snacks').bufdelete.other()
end, { desc = 'Delete Other Buffers' })

-- Resizing windows
vim.keymap.set('n', '<A-h>', '<C-w>5<', { desc = 'Decrease window width' })
vim.keymap.set('n', '<A-l>', '<C-w>5>', { desc = 'Increase window width' })
vim.keymap.set('n', '<A-j>', '<C-w>1+', { desc = 'Increase window height' })
vim.keymap.set('n', '<A-k>', '<C-w>1-', { desc = 'Decrease window height' })

-- Move lines up and down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Move lines left and right
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

return {}
