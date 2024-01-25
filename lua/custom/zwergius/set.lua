-- Line & relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- no line wrap
vim.opt.wrap = false

-- Indents
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Infinite undo
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Set highlight on search
vim.o.hlsearch = true
vim.opt.incsearch = true

-- Scroll buffer
vim.opt.scrolloff = 8

-- Filetype overrides
vim.filetype.add {
  extension = {
    postcss = 'css',
  },
}

-- Autocommand create folder(s) for new file
vim.cmd 'source ~/.config/nvim/vim/auto-mkdir.vim'
