-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

keymap('n', '<leader>e', ':Lex 34<cr>', opts) -- hit again to close

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +6<CR>', opts)
keymap('n', '<C-Down>', ':resize 2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize 2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +6<CR>', opts)

-- Navigate buffers
-- keymap('n', '<S-l>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-l>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-h>', ':bprev<CR>', opts)

keymap('n', '<leader>n', ':bnext<CR>', opts)
-- keymap('n', '<S-h>', ':bprevious<CR>', opts)
keymap('n', '<leader>p', ':bprev<CR>', opts)

-- Insert --
-- Press fast to exit
-- keymap('i', 'jk', '<ESC>', opts)

-- Jump to beginning of line
keymap('n', '<leader>h', '^', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
-- paste over currently selected text without yanking it
-- _ register is black hole. Unrecoverable
keymap('v', 'p', '"_dp', opts)
keymap('v', 'P', '"_dP', opts)
-- Visual Block --
-- Move text up and down
-- keymap('x', 'J', ":move '>+5<CR>gv-gv", opts)
-- keymap('x', 'K', ":move '<2<CR>gv-gv", opts)
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Better terminal navigation
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
keymap('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
keymap('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
keymap('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

keymap('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 14,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
-- vim.keymap.set('n', '<leader>s/', function()
--   builtin.live_grep {
--     grep_open_files = true,
--     prompt_title = 'Live Grep in Open Files',
--   }
-- end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- Nvimtree
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
-- keymap("n", "<leader>f", ":Format<cr>", opts)
keymap('n', '<leader>w', ':w<cr>', opts)
keymap('n', '<leader>q', ':q<cr>', opts)
keymap('n', '<leader>d', ':bdelete<cr>', opts)

keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Move line on the screen rather than by line in the file
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)

-- Select all
vim.keymap.set('n', '<c-a>', 'ggvg', opts)

-- vim.keymap.set('n', 'YY', 'va{Vy', opts)
keymap('n', '<leader>r', ':w<CR>:!python3 %<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader><leader>x', ':source %<CR>', opts)
keymap('n', '<leader>x', ':.lua<CR>', opts)
keymap('v', '<leader>x', ':lua<CR>', opts)

-- undo word by word
vim.keymap.set('i', '<space>', '<C-G>u<space>', opts)
