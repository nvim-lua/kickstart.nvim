-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Add trouble.nvim plugin
  { 'folke/trouble.nvim', event = 'VimEnter', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = function()
    require('trouble').setup {}
  end },
}
