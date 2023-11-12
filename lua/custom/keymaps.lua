-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local k = vim.keymap -- for conciseness

-- [[==== GENERAL KEYMAPS ====]]

-- [[ Search ]]
-- after search highlights everything and you hit enter
-- the highlights are "stuck". To clear them, use leader + nh ("no highlight")
k.set("n", "<leader>nh", ":nohl<CR>")

-- when deleting a single character, don't save that character to the register
k.set("n", "x", '"_x')

-- [[ Manage Splits ]]
k.set("n", "<leader>sv", "<C-w>v", { desc = "Split window Vertically" })
k.set("n", "<leader>sh", "<C-w>s", { desc = "Split window Horitonzally" })
k.set("n", "<leader>se", "<C-w>=", { desc = "Split Equally" })
k.set("n", "<leader>sx", ":close<CR>", { desc = "Split close" })

-- [[ Manage Tabs ]]
k.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
k.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
k.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
k.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })

-- [[ Annoyances in Vim ]]
-- make space be a no-opt in visual and normal mode
k.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap
k.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
k.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Diagnostics ]]
k.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
k.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
k.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
k.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- [[==== PLUGIN KEYMAPS ====]]

-- vim-maximizer
-- keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- [[ Configure Oil ]]
k.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- [[ Configure Telescope ]]
-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files in current project
-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find text in current project
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find current string cursor is on in current project
-- keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- show active buffers
-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- show help tags

-- See `:help telescope.builtin`
k.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
k.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
k.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

k.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
k.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
k.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
k.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
k.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
k.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
k.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
k.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

