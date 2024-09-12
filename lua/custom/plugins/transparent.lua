local transparent = {
  {
    'xiyaowong/transparent.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('transparent').setup {
        groups = {
          'Normal',
          'NormalNC',
          'Comment',
          'Constant',
          'Special',
          'Identifier',
          'Statement',
          'PreProc',
          'Type',
          'Underlined',
          'Todo',
          'String',
          'Function',
          'Conditional',
          'Repeat',
          'Operator',
          'Structure',
          'LineNr',
          'NonText',
          'SignColumn',
          'CursorLine',
          'CursorLineNr',
          'StatusLine',
          'StatusLineNC',
          'EndOfBuffer',
        },
        extra_groups = {
          'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
          'NeoTreeNormal',
          'NeoTreeNormalNC',
          'NeoTreeEndOfBuffer',
          'NeoTreeVertSplit',
        },
        exclude_groups = {},
        on_clear = function() end,
      }

      -- Add additional highlight groups
      vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { 'ExtraGroup' })

      vim.cmd [[TransparentEnable]]
    end,
  },
}

return transparent
