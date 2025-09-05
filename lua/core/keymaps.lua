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

-- Buffer management keymaps
vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<CR>', { desc = '[B]rowse [B]uffers' })
vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>ba', '<cmd>%bd|e#<CR>', { desc = '[B]uffers close [A]ll but current' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<CR>', { desc = '[B]uffer [N]ew' })

-- Quick buffer switching with numbers
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<cmd>buffer ' .. i .. '<CR>', { desc = 'Switch to buffer ' .. i })
end

-- Alternate file (toggle between two most recent files)
vim.keymap.set('n', '<leader><leader>', '<C-^>', { desc = 'Toggle alternate file' })

-- Window management keymaps
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>', { desc = '[W]indow [S]plit horizontal' })
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = '[W]indow [V]ertical split' })
vim.keymap.set('n', '<leader>wc', '<cmd>close<CR>', { desc = '[W]indow [C]lose' })
vim.keymap.set('n', '<leader>wo', '<cmd>only<CR>', { desc = '[W]indow [O]nly (close others)' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = '[W]indow cycle' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = '[W]indow balance sizes' })

-- Window resizing with arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Standard practice for Lua modules that don't need to return complex data
return {}
