-- neorg_setup.lua
return {
  -- Dependency for Neorg: a colorscheme compatible with treesitter
  {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd.colorscheme 'kanagawa'
    end,
  },

  -- Treesitter configuration necessary for Neorg
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- Dependency manager for Neorg
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },

  -- Main Neorg setup
  {
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    version = '*',
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {}, -- Load all the default modules
          ['core.concealer'] = {}, -- Allows for use of icons
          ['core.export'] = {
            config = {
              export_dir = '~/notes/exports', -- Sets the export directory for all files
              exporters = { -- Defines the exporters available and their settings
                markdown = { -- Markdown exporter settings
                  extensions = { 'md' }, -- Specifies the file extensions to use when exporting to Markdown
                },
                html = { -- HTML exporter settings
                  extensions = { 'html' }, -- Specifies the file extensions to use when exporting to HTML
                },
                pdf = { -- PDF exporter settings
                  extensions = { 'pdf' }, -- Specifies the file extensions to use when exporting to PDF
                },
              },
            },
          },
          ['core.journal'] = {
            config = {
              workspace = 'notes', -- Specifies the workspace for journaling
            },
          },
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/notes', -- Path to your notes directory
              },
              default_workspace = 'notes', -- Sets default workspace
            },
          },
        },
      }
      vim.wo.foldlevel = 99 -- Set the foldlevel for vim
      vim.wo.conceallevel = 2 -- Set the conceallevel for better visibility
    end,
  },
}

