vim.o.cursorline = true
vim.o.cursorcolumn = true

return {
    'tummetott/reticle.nvim',
    config = function()
        require('reticle').setup {

            -- add options here or leave empty
        }
    end,
}
