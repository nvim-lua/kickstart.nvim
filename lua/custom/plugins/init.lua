-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  vim.keymap.set('n', '<leader>bc', function()
    local path = vim.fn.expand '%:.'
    vim.fn.setreg('+', path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
  end, { desc = 'Copy relative path of the buffer to clipboard' }),

  vim.keymap.set('n', '<leader>bca', function()
    local path = vim.fn.expand '%'
    vim.fn.setreg('+', path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
  end, { desc = 'Copy absolute path of the buffer to clipboard' }),
}
