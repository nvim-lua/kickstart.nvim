-- Fold code by expression
vim.opt.foldenable = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Turn off line wrapping
vim.opt.wrap = false

-- Typst filetype support
vim.filetype.add { extension = { typ = 'typst' } }

-- Reset the cursor after leaving vim. Without this, the cursor changes to a
-- block for the terminal.
vim.cmd [[
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:ver1
    augroup END
]]
