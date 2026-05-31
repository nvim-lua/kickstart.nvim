vim.opt.fsync = false

-- System Clipboard Integration
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Make line numbers default
vim.opt.nu = true
vim.opt.relativenumber = true

-- Default terminal to pwsh
vim.opt.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
vim.opt.shellcmdflag =
  '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

-- Enable break indent
vim.o.breakindent = true

-- Quality of life bindings for common/essential operations
vim.cmd 'command! W w'
vim.cmd 'command! Qw wq'
vim.cmd 'command! Q q'

-- Save undo history
vim.fn.mkdir(vim.fn.stdpath('data') .. '/undodir', 'p')
vim.opt.undodir = vim.fn.stdpath 'data' .. '/undodir'
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'
vim.opt.colorcolumn = '80'

-- Decrease update time
vim.o.timeoutlen = 300
vim.opt.updatetime = 250

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.opt.guicursor = ''

-- Setup tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.o.autoindent = true
vim.opt.wrap = false

-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Search Highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Cursos and window appearance
vim.opt.cursorline = true

-- Window splitting behavior
vim.opt.splitright = true

-- Disable netrw(built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Window border style
vim.o.winborder = 'rounded'

-- Show invisible characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live substitution preview
vim.o.inccommand = 'split'
