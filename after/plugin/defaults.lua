-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Reminders
-- Because of "Comment" plugin you can comment visual code by pressing "gc"
-- Because of treesitter you can do "CTRL+SPACE" for incremental selection and "ALT+SPACE" for incremental deselection


-- Change the current directory
vim.keymap.set({ 'n', 'v' }, '<leader>cd', ':cd %:h<CR>', { noremap = true, desc = 'Change Directory to Current' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Close the buffer
vim.keymap.set('n', '<leader>bx', ':BufferClose<CR>', { desc = 'Close Buffer' })

-- Enter explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Explorer' })

-- Move text around in visual mode and indent properly
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append line below you to the end of current line with a space, and don't move cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = 'Append line below to current line' })

-- Scroll with cursor in middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up' })

-- Navigate search terms, but keep cursor in middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Use "<leader>y" if you want the yank to go to the system register, otherwise yank only applies to nvim
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank to end of line into system clipboard' })

-- Use "<leader>dd" to delete without saving to a register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- When highlighting a word and pasting over it, don't lose current register value
vim.keymap.set("x", "<leader>pp", [["_dP]], { desc = 'Paste without losing register' })

-- Navigate quick fix commands
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Set terminal keymaps
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', 'jk', [[<C-\><C-n>]])

-- Telescope keymaps
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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false
-- To demonstrate, try typing /vim.* = and see what happens
vim.opt.incsearch = true
-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--  I'm going to use a keymap "<leader>y" for system clipboard to keep the two separate
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true


vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.smartindent = true
