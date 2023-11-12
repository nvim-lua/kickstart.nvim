-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
local opt = vim.opt -- for conciseness

-- [[ LINE NUMBERS ]]
-- -- Make line numbers default
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- [[ LINE WRAPPING ]]
opt.wrap = false

-- [[ BACKSPACE ]]
opt.backspace = "indent,eol,start"

-- [[ MOUSE ]]
-- Enable mouse mode
opt.mouse = 'a'

-- [[ CLIPBOARD ]]
-- Sync clipboard between OS and Neovim.
opt.clipboard:append("unnamedplus")

-- [[ UNDO HISTORY ]]
-- Save undo history
opt.undofile = true

-- [[ SEARCH ]]
-- Case-insensitive searching UNLESS \C or capital in search
-- -- searching with lowercase 'hello' will highlight all cases: 'Hello', 'heLLo', 'hello'
opt.ignorecase = true
-- -- searching with uppercase 'Hello' will highlight only exact matches of 'Hello"
opt.smartcase = true


-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- [[ AUTO COMPLETE ]]
-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- [[ APPEARANCE ]]
-- NOTE: NOT ALL TERMINALS SUPPORT THIS!
opt.termguicolors = true
opt.background = 'dark'
-- Keep signcolumn on by default
opt.signcolumn = 'yes'
-- Enable break indent
opt.breakindent = true

