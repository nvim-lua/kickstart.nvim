-- [[ UI Configs ]]
-- set transparency
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'NonText', { bg = 'none', ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none', ctermbg = 'none' })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'none', ctermbg = 'none' })

-- set WinSeparator & EndOfBuffer to match the highlight on cursor-line-number
vim.api.nvim_set_hl(0, 'WinSeparator', vim.api.nvim_get_hl(0, { name = 'CursorLineNr' }))
vim.api.nvim_set_hl(0, 'EndOfBuffer', vim.api.nvim_get_hl(0, { name = 'CursorLineNr' }))
