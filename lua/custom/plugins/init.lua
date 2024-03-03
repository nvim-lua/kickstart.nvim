-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
local plugins = {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    opts = function()
      -- Default options:
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = '', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      }
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'jubnzv/mdeval.nvim',
    event = 'VeryLazy',
    opt = function()
      return vim.g.markdown_fenced_languages == { 'python', 'cpp' }
    end,
  },
}

return plugins
