-- Function to convert to uppercase and set a mark
vim.api.nvim_create_user_command('SetGlobalMark', function()
  local ok, char = pcall(vim.fn.getcharstr)
  if not ok then
    return
  end

  -- Convert lowercase to uppercase
  if char:match '[a-z]' then
    char = char:upper()
  end

  vim.cmd('normal! m' .. char)
end, {})

-- Function to convert to uppercase and jump to a mark
vim.api.nvim_create_user_command('JumpToGlobalMark', function()
  local ok, char = pcall(vim.fn.getcharstr)
  if not ok then
    return
  end

  -- Convert lowercase to uppercase
  if char:match '[a-z]' then
    char = char:upper()
  end

  vim.cmd("normal! '" .. char)
end, {})

-- Map your preferred key combinations to the functions
vim.keymap.set('n', '<C-m>', ':SetGlobalMark<CR>', { noremap = true })
vim.keymap.set('n', '<C-s>', ':JumpToGlobalMark<CR>', { noremap = true })
