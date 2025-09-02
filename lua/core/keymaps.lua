-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- LSP reload function
local function reload_lsp()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print('No LSP clients running')
    return
  end
  
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end
  
  vim.defer_fn(function()
    vim.cmd('LspStart')
    print('LSP servers reloaded')
  end, 500)
end

-- Reload LSP keybind
vim.keymap.set('n', '<leader>lr', reload_lsp, { desc = '[L]SP [R]eload all servers' })

-- Standard practice for Lua modules that don't need to return complex data
return {}
