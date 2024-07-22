-- Set buffer-local options for Rust files
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = '80'

-- Define key mappings or other configurations specific to Rust
-- For example:
vim.keymap.set('n', '<leader>r', '<CMD>Cargo run<CR>', { desc = 'Run the current Rust project', noremap = true })
vim.keymap.set('n', '<leader>c', '<CMD>Cargo check<CR>', { desc = 'Check the current Rust project', noremap = true })

