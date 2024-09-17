-- transparent.nvim plugin configuration
-- https://github.com/xiyaowong/transparent.nvim

return {
  'xiyaowong/transparent.nvim', -- GitHub repository
  as = 'transparent', -- Optional: rename the plugin to 'transparent'
  config = function()
    require('transparent').setup({
      groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
      extra_groups = { -- extra highlight groups to clear
        'all', -- Also clear background for all highlight groups
      },
      exclude_groups = {}, -- exclude these highlight groups from being cleared
    })
  end,
}


