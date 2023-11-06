-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.guicursor =
"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- vim.opt.guicursor = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- vim.opt.isfname:append("@_@")

vim.opt.colorcolumn = "80"

vim.opt.showtabline = 2

function my_tabline()
    local s = ''
    for i = 1, vim.fn.tabpagenr('$') do
        local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
        local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':p')
        s = s .. '%' .. i .. 'T' .. (bufnr == vim.fn.bufnr('%') and '%1*' or '%2*') .. bufname .. ' '
    end
    return s
end

vim.o.tabline = [[%!v:lua.my_tabline()]]

return {}
