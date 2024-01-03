-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure NvimTree ]]
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<cr>", { desc = 'NvimTree' })
vim.keymap.set('n', '<leader>ee', ":NvimTreeToggle<cr>", { desc = 'NvimTree Toggle' })
vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<cr>', { desc = 'Find file' })
vim.keymap.set('n', '<C-h>', '<C-n><left>')
vim.keymap.set('n', '<C-j>', '<C-n><up>')
vim.keymap.set('n', '<C-k>', '<C-n><down>')
vim.keymap.set('n', '<C-l>', '<C-n><right>')

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Configuring vim tests ]]
vim.keymap.set('n', '<leader>t', ":VimTest<cr>", { desc = 'VimTest' })
vim.keymap.set('n', '<leader>tn', ":TestNearest", { desc = "Run Nearest test" })
vim.keymap.set('n', '<leader>tf', ":TestFile", { desc = "Run Current file" })
vim.keymap.set('n', '<leader>ts', ":TestSuite", { desc = "Run Test suite" })
vim.keymap.set('n', '<leader>tl', ":TestLast", { desc = "Runs the last test" })
vim.keymap.set('n', '<leader>tv', ":TestVisit", { desc = "Visit the file that was last run" })
