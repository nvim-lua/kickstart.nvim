vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.relativenumber = true
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true }) -- Set keymap to exit terminal using 'exit'
vim.keymap.set('n', '<leader>p', ':bprev<CR>', { noremap = true, silent = true, desc = 'Open previous buffer' })
vim.keymap.set('n', '<leader>n', ':bnext<CR>', { noremap = true, silent = true, desc = 'Open next buffer' })
vim.keymap.set('n', '<leader>m', ':cd %:p:h<CR>', { noremap = true, silent = true, desc = 'Move to current buffer' })
vim.cmd.colorscheme 'rose-pine-main' -- Set custom colorscheme [[ NOTE: Never set it to "onedark" cuz it breaks the editor ]]