-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.keymap.set('n', '<C-k>', '10k', { desc = 'Scroll up and center' })
vim.keymap.set('n', '<C-j>', '10j', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-c>', 'ggVGy', { desc = 'copy file', noremap = true })

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        integrations = {
          telescope = true,
          treesitter = true,
          cmp = true,
          gitsigns = true,
        },
        custom_highlights = function(colors)
          return {
            LineNr = { fg = colors.mauve },
            CursorLineNr = { fg = colors.lavender, bold = true },
            Visual = { bg = colors.surface1 },
            TelescopeSelection = { bg = colors.surface1 },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'tokyo-night',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'sindrets/diffview.nvim',
      'ibhagwan/fzf-lua',
    },
    config = function()
      local neogit = require 'neogit'

      vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open Neogit' })

      neogit.setup {}
    end,
  },
}
