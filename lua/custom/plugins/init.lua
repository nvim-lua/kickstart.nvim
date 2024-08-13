-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- underline the word your cursor is on
  {
    'echasnovski/mini.cursorword',
    version = '*',
    opts = {}
  },
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup({
        copy_sync = {
          enable = false,
        },
        resize = {
          enable_default_keybindings = true,
          resize_step_x = 50,
          resize_step_y = 10,
        }
      })
    end
  },
  {
    'ThePrimeagen/harpoon', -- Enhance marks
    dependencies = {
      -- requires to work
      'nvim-lua/plenary.nvim'
    }
  },
  'ojroques/nvim-osc52',
  'szw/vim-maximizer'
}
