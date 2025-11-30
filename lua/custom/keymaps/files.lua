-- File navigation and Telescope-related keybindings

-- File explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { desc = 'Telescope file browser' })

-- Telescope pickers (additional to Kickstart defaults)
-- Note: These require telescope to be loaded, so we'll use pcall for safety
local ok, telescope_builtin = pcall(require, 'telescope.builtin')
if ok then
  vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Search help' })
  vim.keymap.set('n', '<leader>fr', telescope_builtin.oldfiles, { desc = 'Recent files' })
  vim.keymap.set('n', '<leader>fc', telescope_builtin.current_buffer_fuzzy_find, { desc = 'Search in current buffer' })
end
