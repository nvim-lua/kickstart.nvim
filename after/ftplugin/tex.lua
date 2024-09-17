-- vim.opt.breakindentopt = "shift:2"
-- Replacement for this: vim.opt.showbreak = "↪ "
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 0

vim.cmd([[
function! MyFormatExpr(start, end)
    silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
endfunction

set formatexpr=MyFormatExpr(v:lnum,v:lnum+v:count-1)
]])
