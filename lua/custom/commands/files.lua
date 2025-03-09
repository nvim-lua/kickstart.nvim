-- Update file on focus if it was changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, { command = 'checktime' })
