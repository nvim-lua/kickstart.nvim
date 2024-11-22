return {
  --
  -- COLORSCHEMES
  --
  { -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { 'zenbones-theme/zenbones.nvim', dependencies = 'rktjmp/lush.nvim', lazy = false, priority = 1000 },
  { 'yorik1984/newpaper.nvim', priority = 1000 },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'scottmckendry/cyberdream.nvim', lazy = false, priority = 1000 },
  { 'rebelot/kanagawa.nvim', priority = 1000 },
  { 'EdenEast/nightfox.nvim', priority = 1000 },
}
