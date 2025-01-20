return {
  'echasnovski/mini.map',
  version = '*',
  -- vim.keymap.set('n', '<leader>mo', MiniMap.open, { desc = 'Open MiniMap' }),
  config = function()
    -- require('mini.map').setup()
    local map = require 'mini.map'

    local diagnostic_integration = map.gen_integration.diagnostic {
      error = 'DiagnosticFloatingError',
      warn = 'DiagnosticFloatingWarn',
      info = 'DiagnosticFloatingInfo',
      hint = 'DiagnosticFloatingHint',
    }

    local builtin_search_integration = map.gen_integration.builtin_search()

    local gitsigns_integration = map.gen_integration.gitsigns {
      add = 'GitSignsAdd',
      change = 'GitSignsChange',
      delete = 'GitSignsDelete',
    }

    map.setup {
      integrations = {
        diagnostic_integration,
        builtin_search_integration,
        gitsigns_integration,
      },
    }
  end,

  keys = {
    {
      '<leader>mt',
      function()
        require('mini.map').toggle()
      end,
      desc = 'Toggle minimap',
    },
    {
      '<leader>mc',
      function()
        require('mini.map').close()
      end,
      desc = 'Close minimap',
    },
    {
      '<leader>mf',
      function()
        require('mini.map').toggle_focus()
      end,
      desc = 'Toggle minimap focus',
    },
    {
      '<leader>mo',
      function()
        require('mini.map').open()
      end,
      desc = 'Open minimap',
    },
    {
      '<leader>mr',
      function()
        require('mini.map').refresh()
      end,
      desc = 'Refresh minimap',
    },
    {
      '<leader>ms',
      function()
        require('mini.map').toggle_side()
      end,
      desc = 'Toggle minimap side',
    },
  },
}
