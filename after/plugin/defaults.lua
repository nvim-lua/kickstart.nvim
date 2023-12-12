vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.relativenumber = true

-- Set custom colorscheme [[ NOTE: Never set it to "onedark" cuz it breaks the editor ]]
vim.cmd.colorscheme 'gruvbox'

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
-- vim.keymap.set('n', '<>', [[]], {})
