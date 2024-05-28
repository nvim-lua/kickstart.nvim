vim.opt.breakindentopt = "shift:2"
vim.opt.shiftwidth = 4
vim.opt.textwidth = 0

vim.cmd [[
function! MyFormatExpr(start, end)
    silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
endfunction

set formatexpr=MyFormatExpr(v:lnum,v:lnum+v:count-1)
]]
