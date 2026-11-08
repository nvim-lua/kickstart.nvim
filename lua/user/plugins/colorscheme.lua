-- [[ Colorschemes ]]
-- tokyonight is the default; catppuccin, github and iceberg are available
-- through <leader>uc (picker) or the <leader>u* shortcuts in keymaps.lua.

-- catppuccin compiles a cache in setup(), so only set it up when it's chosen
vim.api.nvim_create_autocmd('ColorSchemePre', {
  group = vim.api.nvim_create_augroup('user-catppuccin', { clear = true }),
  pattern = 'catppuccin*',
  once = true,
  callback = function()
    require('catppuccin').setup {
      custom_highlights = function()
        return {
          WinSeparator = { fg = '#ff0000' },
        }
      end,
    }
  end,
})

vim.cmd.colorscheme 'tokyonight-night'
vim.cmd.hi 'Comment guifg=#a883a5 gui=italic'
vim.cmd.hi 'WinSeparator guifg=#ff0000'
vim.o.laststatus = 3
