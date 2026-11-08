-- [[ Colorschemes ]]
-- tokyonight is the default; catppuccin, github and iceberg are available
-- through <leader>uc (picker) or the <leader>u* shortcuts in keymaps.lua.

require('catppuccin').setup {
  custom_highlights = function()
    return {
      WinSeparator = { fg = '#ff0000' },
    }
  end,
}

vim.cmd.colorscheme 'tokyonight-night'
vim.cmd.hi 'Comment guifg=#a883a5 gui=italic'
vim.cmd.hi 'WinSeparator guifg=#ff0000'
vim.o.laststatus = 3
