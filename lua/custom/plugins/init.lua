-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.g.have_nerd_font = true
vim.o.relativenumber = true

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

local function copy_path(path_type)
  local path_to_copy
  local msg_suffix

  if path_type == 'full' then
    path_to_copy = vim.fn.expand '%:p'
    msg_suffix = 'full path'
  elseif path_type == 'relative' then
    path_to_copy = vim.fn.expand '%:.'
    msg_suffix = 'relative path'
  elseif path_type == 'filename' then
    path_to_copy = vim.fn.expand '%:t'
    msg_suffix = 'filename'
  else
    print 'Invalid path type specified for copy_path'
    return
  end

  vim.fn.setreg('+', path_to_copy)
  print('Copied ' .. msg_suffix .. ' to clipboard')
end
vim.keymap.set('n', '<leader>cp', function()
  copy_path 'full'
end, { desc = 'Copy full file path' })
vim.keymap.set('n', '<leader>cr', function()
  copy_path 'relative'
end, { desc = 'Copy relative file path' })
vim.keymap.set('n', '<leader>cf', function()
  copy_path 'filename'
end, { desc = 'Copy filename' })

require('guess-indent').setup {}

return {}
