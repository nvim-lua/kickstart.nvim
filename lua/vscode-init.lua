-- VSCode Specific Neovim configuration

-- * Custom Keybings * --

-- local keymap = vim.keymap.set
-- local opts = { nmap = true, silent = true }

-- Remap leader key
-- keymap("n", "<Space>", "", opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- * VSCode Neovim Configuration
vim.g.have_nerd_font = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true