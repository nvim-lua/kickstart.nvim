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
          side = 'right', -- Position of the tree
          width = 40,
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

  -- Add lazygit.nvim plugin
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'LazyGit' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Open LazyGit' },
    },
  },

  -- Aerial plugin to see document signatures
  {
    'stevearc/aerial.nvim',
    cmd = { 'AerialToggle' },
    keys = {
      { '<leader>ga', '<cmd>AerialToggle<CR>', desc = 'Toggle Aerial Outline' },
    },
    config = function()
      require('aerial').setup()
    end,
  },
}
