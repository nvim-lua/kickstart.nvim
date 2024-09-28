-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Enable break indent
vim.opt.breakindent = true

--  Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'i'

-- preserve indents as much as possible
vim.opt.preserveindent = true

-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Minimal number of screen lines tExo keep above and below the cursor.
vim.opt.scrolloff = 10

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

vim.opt.smartcase = true

vim.opt.smartindent = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
--
-- use 24-bit RGB color in TUI
vim.opt.termguicolors = true

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

-- Decrease update time
vim.opt.updatetime = 250
