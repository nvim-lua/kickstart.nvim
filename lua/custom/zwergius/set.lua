-- Line & relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indents
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Set highlight on search
vim.o.hlsearch = false
vim.opt.incsearch = true

-- Filetype overrides
vim.filetype.add {
  extension = {
    postcss = 'css',
  },
}

-- Autocommand create folder(s) for new file
vim.cmd 'source ~/.config/nvim/vim/auto-mkdir.vim'
