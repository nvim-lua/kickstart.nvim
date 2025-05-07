-- Tab management keymaps
-- These provide VS Code-like tab navigation and management

-- Create a new empty tab
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })

-- Create a new tab and open Telescope file finder
vim.keymap.set('n', '<leader>to', ':tabnew<CR>:Telescope find_files<CR>', { desc = 'New tab with file' })

-- Close the current tab
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })

-- Navigate to next tab (similar to VS Code)
vim.keymap.set('n', '<C-PgDn>', 'gt', { desc = 'Next tab' })

-- Navigate to previous tab (similar to VS Code)
vim.keymap.set('n', '<C-PgUp>', 'gT', { desc = 'Previous tab' })

-- Add this keymap group to Which-key if you're using it
-- (the plugin will automatically pick this up on next restart)
return {}