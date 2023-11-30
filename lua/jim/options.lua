-- options.lua
-- ../../init.lua
-- plugins:   ~/.local/share/kickstart/lazy/
--
--  TODO
--  options:  use vim.go, vim.wo, vim.bo   (ie scope)
--  variables  use vim.g, vim.w, vim.b ...
vim.cmd 'set background=light'
vim.cmd("colorscheme  gruvbox") -- be sure installed in config

--  :h 'fo'
--  where does line belong?
--  +r comments will be autoadded
vim.cmd([[ set formatoptions+=r]])

-- scrolloff = 999, means cursor line is fixed, in center of screen
-- to always display top/bottom 8 lines, set scrolloff=8
-- global options
vim.g.scrolloff       = 999
vim.g.colorcolumn     = "80"

-- Set highlight on search
vim.o.hlsearch        = false

-- Make line numbers default
vim.wo.number         = true
vim.wo.relativenumber = true
vim.wo.foldmethod     = "manual" -- cleaner vs "marker"
vim.wo.foldcolumn     = '1'      -- can be '0-9' (string)

-- Enable mouse mode
vim.o.mouse           = 'a'

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.o.clipboard       = 'unnamedplus'

-- Enable break indent (windows)
vim.w.breakindent     = true

-- Hitting <TAB>  (experimnetal)
--
-- tabstop (ts) is not what I think it is <TAB>
-- It is "Number of spaces that a <Tab> in the file counts for." and not what always displays on screen
vim.o.ts              = 2 -- 1 <TAB> is 2 characters

-- in doubt?   sw and expandtab are important ones
-- shiftwidth (sw) refers to number of spaces when using >> or <<
vim.o.sw              = 2
-- tw = maximum width of text (or 0 to disable)

-- <TAB>  becomes all spaces, no <TAB> ch
vim.o.expandtab       = true

-- don't break within a word
vim.o.linebreak       = false



--
-- inccommand: usage :%s/vim/nvim  will open horiz split; show only lines to be changed
vim.o.inccommand = "split"


-- Save undo history
vim.o.undofile      = true

-- Case-insensitive (1) searching UNLESS \C or capital in search
-- (2) Plugins:  built-in begin with lower case; 3rd party begin with Upper case
--  normally, must use :Telescope, now :telescope works
vim.o.ignorecase    = true
vim.o.smartcase     = true

-- Keep signcolumn on by default
vim.wo.signcolumn   = 'yes'

-- Decrease update time
vim.o.updatetime    = 250
vim.o.timeoutlen    = 300 -- time mapping waits for next char
vim.o.ttimeoutlen   = 10  -- time <ESC> delays before registers

-- Set completeopt to have a better completion experience
vim.o.completeopt   = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this (yes: 2023-09-03)
-- gives full color range, in otherwise old technology: terminals
vim.o.termguicolors = true
