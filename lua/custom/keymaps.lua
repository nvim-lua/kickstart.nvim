-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Add any other general-purpose keymaps you want here
vim.keymap.set('n', '<leader>T', function()
  require('custom.lsp.clangd'):pick_target()
end, { desc = 'Choose [T]arget' })

-- Standard practice for Lua modules that don't need to return complex data
return {}
