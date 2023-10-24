-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Search options
vim.opt.hlsearch = false
vim.opt.incsearch = true -- show matching in file as it is typed

-- Make line numbers default, and use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set tab and indent options
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cindent = true -- C programming smart indents
vim.opt.smartindent = true -- like cindent, but works for other languages

-- Wrap lines wider than the width of the window. Visual only, doesn't change text in buffer
vim.opt.wrap = false
-- vim.o.breakindent = true -- wrapped lines will continue visually indented

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default @todo: figure out what this is
vim.opt.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Don't use a buffer swapfile or make backup before overwritting
vim.opt.swapfile = false
vim.opt.backup = false

-- Minimum number of lines to scroll when the cursor gets off the screen
vim.opt.scrolloff = 8

-- Not sure what this does - took from primeagon setup
vim.opt.isfname:append("@-@")

-- Set visual column at 100 spaces
vim.opt.colorcolumn = "100"
