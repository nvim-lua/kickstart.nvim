local utils = require('config.utils')

-- Basic Keymaps
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = "[P]roject [V]iew" })
vim.keymap.set('n', '<C-c>', '<ESC><ESC>', { silent = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('n', '>', '>gv', { silent = true })
vim.keymap.set('n', '<', '<gv', { silent = true })

-- Miscellaneous Navigation Keymaps
vim.keymap.set('n', 'J', 'mzj`z')
vim.keymap.set('n', '<c-d>', '<C-d>zz', { desc = 'Half Page Jumping Up' })
vim.keymap.set('n', '<c-u>', '<C-u>zz', { desc = 'Half Page Jumping Down' })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gp', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Quick Fix Nav Up' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Quick Fix Nav Down' })

-- Buffer Navigation Keymaps
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>zz', { desc = 'Quick Nav Buf Next' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprev<CR>zz', { desc = 'Quick Nav Buf Prev' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Quick Nav Buf Delete' })
vim.keymap.set('n', '<leader>bs', '<cmd>split<CR>', { desc = 'Openn Buf Horizontal Split' })
vim.keymap.set('n', '<leader>bv', '<cmd>vsp<CR>', { desc = 'Open Buf Vertical Split' })
vim.keymap.set('n', '<leader>bt', '<cmd>terminal<CR>')

-- -- open terminal for R and Python
-- vim.keymap.set('n', '<leader>bR', '<cmd>terminal R<CR>', { desc = 'Open R Terminal' })
-- vim.keymap.set('n', '<leader>bP', '<cmd>terminal python<CR>', { desc = 'Open Python Terminal' })

-- Editing Keymaps
vim.keymap.set('x', '<leader>p', [["_dP"]], { desc = 'Paste without register' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d"]], { desc = 'Delete without register' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to + register' })
vim.keymap.set('n', '<leader>Y', '"+Y')
-- replace current word in current scope
vim.keymap.set(
  'n',
  '<leader>rw',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { desc = '[R]eplace Current [W]ord in Current Scope' }
)
-- replace current word in file scope
vim.keymap.set(
  'n',
  '<leader>rW',
  ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
  { desc = '[R]eplace Current [W]ord in File Scope' }
)

-- Open vertical split pane

-- File Management Keymaps
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww $HOME/.local/bin/tmux_sessionizer<CR>', { desc = 'Open Session' })
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'Set Current File to Executable', silent = true })

-- Telescope Keymaps
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(
    require('telescope.themes').get_dropdown({ winblend = 10, previewer = false })
  )
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = 'Search [G]it [B]ranches' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = 'Search [G]it [C]ommits' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })

vim.keymap.set({ 'n', 'v' }, '<leader>sh', function()
  local query = utils.get_search_query()
  require('telescope.builtin').help_tags({ search = query, initial_mode = 'insert', default_text = query })
end, { desc = '[S]earch [H]elp' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', function()
  local query = utils.get_search_query()
  require('telescope.builtin').grep_string({ search = query, initial_mode = 'insert', default_text = query })
end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sp', function()
  require('telescope.builtin').grep_string({ search = vim.fn.input('Grep Search > ') })
end, { desc = '[S]earch [P]roject' })
vim.keymap.set('n', '<leader>sG', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sg', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- Tree-sitter Keymaps
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>ef', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>ee', function()
--   vim.diagnostic.setloclist()
--   vim.cmd('lopen')
-- end, { desc = 'Open the diagnostics location list' })

-- local runner = require("quarto.runner")
-- vim.keymap.set('n', '<leader>qrc', runner.run_cell, { desc = '[R]un [C]ell', silent = true })
-- vim.keymap.set('n', '<leader>qra', runner.run_above, { desc = '[R]un cell and [A]bove', silent = true })
-- vim.keymap.set('n', "<leader>qrA", runner.run_all, { desc = "run all cells", silent = true })
-- vim.keymap.set('n', "<leader>qrl", runner.run_line, { desc = "run line", silent = true })
-- vim.keymap.set('v', '<leader>qr', runner.run_range, { desc = "run visual range", silent = true })
-- vim.keymap.set('n', '<leader>qRA', function()
--   runner.run_all(true)
-- end, { desc = "run all cells of all languages", silent = true })

-- Refactoring Keymaps
-- vim.keymap.set({ "x" }, "<leader>re", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
--   { noremap = true, silent = true, expr = false, desc = "Extract Function" })
-- vim.keymap.set({ "x" }, "<leader>rf", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
--   { noremap = true, silent = true, expr = false, desc = "Extract Function To File" })
-- vim.keymap.set({ "x" }, "<leader>rv", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
--   { noremap = true, silent = true, expr = false, desc = "Extract Variable" })
-- vim.keymap.set({ "n" }, "<leader>rI", [[<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
--   { noremap = true, silent = true, expr = false, desc = "Inline Variable" })
-- vim.keymap.set({ "n", "x" }, "<leader>ri", [[<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
--   { noremap = true, silent = true, expr = false, desc = "Inline Variable" })
--
-- vim.keymap.set({ "n" }, "<leader>rb", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
--   { noremap = true, silent = true, expr = false, desc = "Extract Block" })
-- vim.keymap.set({ "n" }, "<leader>rbf", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
--   { noremap = true, silent = true, expr = false, desc = "Extract Block To File" })
