return {
  'alexxGmZ/e-ink.nvim',
  priority = 1000,
  config = function()
    -- Set background BEFORE applying colorscheme
    vim.opt.background = 'light' -- or 'dark'
    local mono = require('e-ink.palette').mono()
    vim.api.nvim_set_hl(0, 'Cursor', { bg = mono[16] })
    vim.api.nvim_set_hl(0, 'Cursor', { fg = mono[1], bg = mono[16] })
    require('e-ink').setup()
    vim.cmd.colorscheme 'e-ink'

    -- Get palette AFTER colorscheme setup
    local everforest = require('e-ink.palette').everforest()

    -- Target a VALID highlight group
    -- vim.api.nvim_set_hl(0, 'Comment', { fg = everforest.purple })
  end,
}
