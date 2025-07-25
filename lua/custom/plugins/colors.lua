return {
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('tokyonight').setup {
  --       styles = {
  --         comments = { italic = false }, -- Disable italics in comments
  --       },
  --     }
  --
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --   end,
  -- },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000000,
    opts = {
      borderless_pickers = false,
      saturation = 0.95,
      cache = true,
    },
    init = function()
      vim.cmd 'colorscheme cyberdream'
      vim.api.nvim_set_hl(0, 'TroubleNormal', { bg = 'none', ctermbg = 'none' })
      vim.api.nvim_set_hl(0, 'TroubleNormalNC', { bg = 'none', ctermbg = 'none' })
      vim.api.nvim_set_hl(0, 'TroubleNormal', { bg = 'none', ctermbg = 'none' })
      vim.api.nvim_set_hl(0, 'TroubleNormalNC', { bg = 'none', ctermbg = 'none' })
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#3c4048', bg = 'none' })
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#7b8496' })
      vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#232429' })
      vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { bg = '#232429' })
      vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = '#232429', underline = true })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff' })
    end,
  },
}
