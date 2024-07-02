-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<A-h>", "<C-w>h", { silent = true })
keymap.set("n", "<A-l>", "<C-w>l", { silent = true })
keymap.set("n", "<A-j>", "<C-w>j", { silent = true })
keymap.set("n", "<A-k>", "<C-w>k", { silent = true })
keymap.set("n", "<leader>dv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>dh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>de", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>dx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

keymap.set('n', '<leader>dd', 'yyp') -- duplicate line 
keymap.set('n', '<leader>l', 'yyp') -- duplicate line 
keymap.set('n', 'dd', '"_dd') -- duplicate line not passing deleted line to registry

keymap.set('n', '<C-a>', 'ggVG') -- select-all 
keymap.set('n', 'J', '5j')
keymap.set('n', 'K', '5k')
keymap.set('v', 'J', '5j')
keymap.set('v', 'K', '5k')

keymap.set('n', '<leader>rr', ':e!<CR>') -- revert file
keymap.set('n', '<leader>w', ':w<CR>') -- saves file
keymap.set('n', '<leader>q', ':q<CR>') -- quit 

keymap.set('n', '<leader>zz', ':luafile %<CR>') -- re-source this

-- line highlight
vim.cmd[[ highlight LineHighlight ctermbg=darkgray guibg=black ]]
keymap.set("n", "<leader>q",  ":call matchadd('LineHighlight', '\\%'.line('.').'l')<cr>" , { silent = true })
keymap.set("n", "<leader>!", ":call clearmatches()<cr>", { silent = true })


-- bookmarks
keymap.set('n', '#2', ':BookmarkNext<CR>')
keymap.set('n', '<C-F2>', ':BookmarkToggle<CR>')

----------------------
-- PLUGINS

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
-- keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer // todo

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

keymap.set("n", "<leader>t", "<cmd>Telescope vim_bookmarks current_file<cr>")
keymap.set("n", "<leader>tt", "<cmd>Telescope vim_bookmarks all<cr>")


-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- move
local opts = { noremap = true, silent = false }
-- Normal-mode commands
keymap.set('n', '<S-A-k>', ':MoveLine(-1)<CR>', opts)
keymap.set('n', '<S-A-j>', ':MoveLine(1)<CR>', opts)
-- keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
-- keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
-- Visual-mode commands
keymap.set('v', '<S-A-j>', ':MoveBlock(1)<CR>', opts)
keymap.set('v', '<S-A-k>', ':MoveBlock(-1)<CR>', opts)
-- keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
-- keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

-- Harpoon
keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end, opts)
keymap.set("n", "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, opts)
keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end, opts)
keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end, opts)
keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end, opts)
keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end, opts)

-- undotree
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

keymap.set("n",    "<Tab>",         ">>",  opts)
keymap.set("n",    "<S-Tab>",       "<<",  opts)
keymap.set("v",    "<Tab>",         ">gv", opts)
keymap.set("v",    "<S-Tab>",       "<gv", opts)
