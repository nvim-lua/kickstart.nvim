-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- gruvbox theme
  {'morhetz/gruvbox', config = function() vim.cmd.colorscheme('gruvbox') end },
  -- Noctis Theme
  { 'talha-akram/noctis.nvim', name = 'noctis' },
  -- Catppuccin theme
  { 'catppuccin/nvim', name = 'catppuccin' },

  -- nvim-tree
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
}
