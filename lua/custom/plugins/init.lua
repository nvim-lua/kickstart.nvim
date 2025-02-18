-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Add trouble.nvim plugin
  { 'folke/trouble.nvim', event = 'VimEnter', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = function()
    require('trouble').setup {}
  end },

  -- Mode Manager Plugin (local)
  {
    dir = vim.fn.stdpath('config') .. '/lua/custom/plugins/mode_manager',
    name = 'mode_manager',
    event = 'VimEnter',
    config = function()
      require('custom.plugins.mode_manager').setup()
    end,
  },
}
