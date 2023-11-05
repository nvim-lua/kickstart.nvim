return {
  -- {
  --   'jacoborus/tender.vim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'tender'
  --   end,
  -- },

  -- {
  --   "ronisbr/nano-theme.nvim",
  --   priority = 1000,
  --   config = function()
  --   end
  -- },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },

  -- Lualine config
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

}
