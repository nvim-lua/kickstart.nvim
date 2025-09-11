-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load Nix-controlled settings if available
pcall(require, 'nix-settings')

-- Place custom vim options here

-- Set based on your font installation
vim.g.have_nerd_font = true

-- [[ Essential Options from Kickstart ]]
-- These MUST be set since we're not loading kickstart's defaults

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse and interaction
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.showmode = false -- Don't show mode since we have a statusline

-- Clipboard - sync with system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Indentation settings
vim.opt.breakindent = true -- Enable break indent
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Save undo history
vim.opt.undofile = true

-- Search settings
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true -- Unless capital in search
vim.opt.hlsearch = true -- Highlight search results

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10
