-- [[ Options ]]
-- See :help option-list

-- For custom functions later
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

-- Only mouse in [h]elp windows
-- Or [a]llways
vim.opt.mouse = "a"

-- statusline already shows mode
vim.opt.showmode = false

-- Copy from anywhere
vim.opt.clipboard = "unnamedplus"

-- Visual wrap keeps indentation
vim.opt.breakindent = true

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Text keeps moving, if not always on
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
-- For which-key
vim.opt.timeoutlen = 500

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "nosplit"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

-- wrap between words
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.softtabstop = 4

-- Don't keep buffer open when opening new file
vim.opt.hidden = false

-- Combined with mapping <Esc> to clear highlights
vim.opt.hlsearch = true
