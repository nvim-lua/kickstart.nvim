-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local opts = { noremap = true, silent = true }

--Remap space as leader key
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

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Clear highlights
keymap('n', '<leader>nh', '<cmd>nohlsearch<CR>', opts)

-- delete single character without copying into register
keymap('n', 'x', '"_x', opts)

-- Close buffers
keymap('n', '<leader>bd', '<cmd>:bd<CR>', opts)
keymap('n', '<leader>bD', '<cmd>Bdelete!<CR>', opts)

-- Write file
keymap('n', '<leader>fs', '<cmd>:write<CR>', opts)
keymap('n', '<leader>fw', '<cmd>:write<CR>', opts)
keymap('n', '<leader>fS', '<cmd>:wa<CR>', opts)
keymap('n', '<leader>fW', '<cmd>:wa<CR>', opts)

-- Safe quit
keymap('n', '<Leader>qq', ':quitall<CR>', opts)

-- Force quit
keymap('n', '<Leader>Q', ':quitall!<CR>', opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap('i', 'jk', '<ESC>', opts)
keymap('v', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Search will center on the line it's found in
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', '#', '#zz', opts)
keymap('n', '*', '*zz', opts)

-- increment/decrement numbers
keymap('n', '<leader>+', '<C-a>', opts) -- increment
keymap('n', '<leader>-', '<C-x>', opts) -- decrement

-- window management
keymap('n', '<leader>wv', '<C-w>v', opts) -- split window vertically
keymap('n', '<leader>wh', '<C-w>s', opts) -- split window horizontally
keymap('n', '<leader>w-', '<C-w>s', opts) -- split window horizontally
keymap('n', '<leader>wd', ':close<CR>', opts) -- close current split window

keymap('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
keymap('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
keymap('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
keymap('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab
