-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear search highlights with Escape in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode with double Escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NOTE: Window navigation is handled by nvim-tmux-navigator plugin
-- which provides seamless navigation between vim splits and tmux panes

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
