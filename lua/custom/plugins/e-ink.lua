return {
  'alexxGmZ/e-ink.nvim',
  config = function()
    --   -- Set background BEFORE applying colorscheme
    vim.opt.background = 'dark' -- or 'dark'
    -- vim.opt.background = 'light' -- or 'dark'
    -- require('e-ink').setup()
    -- --   -- Get palette AFTER colorscheme setup
    -- local everforest = require('e-ink.palette').everforest()
    -- local mono = require('e-ink.palette').mono()
    --   -- Target a VALID highlight group
    --   vim.api.nvim_set_hl(0, 'CursorColumn', { fg = mono[16] })
    --   vim.api.nvim_set_hl(0, 'CursorLine', { fg = mono[16] })
    -- vim.api.nvim_set_hl(0, 'Comment', { fg = mono[5] })
    -- vim.api.nvim_set_hl(0, 'Function', { fg = everforest.statusline3 })
    -- vim.api.nvim_set_hl(0, 'Constant', { fg = everforest.blue2 })
    -- vim.api.nvim_set_hl(0, 'String', { fg = everforest.green })
    -- vim.api.nvim_set_hl(0, 'Operator', { fg = everforest.orange })
    -- vim.api.nvim_set_hl(0, 'Delimiter', { fg = everforest.yellow })
    -- vim.api.nvim_set_hl(0, '@keyword.return', { fg = everforest.red })
    -- vim.api.nvim_set_hl(0, 'Identifier', { fg = everforest.statusline3 })
    --   -- vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#000000' })
  end,
}
