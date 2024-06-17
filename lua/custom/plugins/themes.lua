return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'kanagawa'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'morhetz/gruvbox',
    name = 'gruvbox',
    priority = 1000,
    init = function() end,
  },
}
