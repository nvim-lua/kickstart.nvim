-- return {
--   'AlexvZyl/nordic.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('nordic').load()
--     vim.cmd.colorscheme 'nordic'
--   end,
-- }

return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup {
      commentStyle = {
        italic = true,
      },
      -- optional: your custom config here
    }
    vim.cmd 'colorscheme kanagawa-dragon'
  end,
}

-- return {
--   'aliqyan-21/darkvoid.nvim',
--   priority = 1000,
--   lazy = false,
--   init = function()
--     require('darkvoid').setup {
--       glow = true,
--       transparent = true,
--       colors = {
--         fg = '#c0c0c0',
--         bg = '#1c1c1c',
--         cursor = '#fdd41b',
--         line_nr = '#404040',
--         visual = '#303030',
--         comment = '#737373',
--         string = '#66b2b2',
--         func = '#1bfd9c',
--         kw = '#fe5e58',
--         identifier = '#b1b1b1',
--         type = '#a1a1a1',
--         search_highlight = '#fdd41b',
--         operator = '#1bfd9c',
--         bracket = '#e6e6e6',
--         preprocessor = '#4b8902',
--         bool = '#d1d1d1',
--         constant = '#b2d8d8',
--
--         -- gitsigns colors
--         added = '#baffc9',
--         changed = '#ffffba',
--         removed = '#ffb3ba',
--
--         -- Pmenu colors
--         pmenu_bg = '#1c1c1c',
--         pmenu_sel_bg = '#1bfd9c',
--         pmenu_fg = '#c0c0c0',
--
--         -- EndOfBuffer color
--         eob = '#3c3c3c',
--
--         -- Telescope specific colors
--         border = '#fe5e58',
--         title = '#ffffff',
--
--         -- bufferline specific colors
--         bufferline_selection = '#1bfd9c',
--
--         -- LSP diagnostics colors
--         error = '#dea6a0',
--         warning = '#d6efd8',
--         hint = '#bedc74',
--         info = '#7fa1c3',
--       },
--     }
--     -- You can configure highlights by doing something like:
--     vim.cmd.hi 'Comment gui=none'
--     vim.cmd.hi 'Normal guibg=none'
--     vim.cmd.hi 'Normal guibg=none'
--     vim.cmd.colorscheme 'darkvoid'
--   end,
-- }
