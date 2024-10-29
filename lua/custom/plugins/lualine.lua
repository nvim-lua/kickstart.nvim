return {
  -- Use lualine instead of mini.statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          globalstatus = true,
        },
      }
    end,
  },
}
