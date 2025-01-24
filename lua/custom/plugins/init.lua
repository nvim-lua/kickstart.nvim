-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Other plugins...

  -- Add nvim-tree plugin
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For file icons
    config = function()
      require('nvim-tree').setup {
        disable_netrw = true, -- Disable netrw
        hijack_netrw = true, -- Hijack netrw for nvim-tree
        view = {
          side = 'left',
          width = 30,
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        diagnostics = {
          enable = true, -- Show diagnostic info
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
        git = {
          enable = true, -- Show git status
        },
        filters = {
          dotfiles = false, -- Show hidden files
        },
      }
    end,
  },
}
