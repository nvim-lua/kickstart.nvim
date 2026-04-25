return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  dependencies = {
    {
      'ABDsheikho/nvim-keysitter',
      -- dir = '~/Repos/nvim-keysitter/',
      -- name = 'keysitter',
      config = function()
        local keysitter = require 'keysitter'
        local tsto = keysitter.new('treesitter-textobjects', { group_prefix = 'o' })

        -- a setup function
        tsto.setup({ 'FileType', 'BufEnter' }, 'keysitter', function()
          -- tsto:set('f', 'function'):around():inner():next():prev()

          for k, v in pairs {
            -- ['b'] = 'block', -- or b for brace-less languages like python
            ['f'] = 'function',
            ['i'] = 'conditional',
            ['l'] = 'loop',
            ['r'] = 'return',
            ['t'] = 'attribute',
            ['x'] = 'regex',
          } do
            tsto:set(k, v):around():inner():next():prev()
          end

          tsto:set('/', 'comment'):around():inner():goto_start()
          tsto:set('{', 'block'):around():inner():goto_start():goto_end { key = '}' }
          tsto:set('(', 'call'):around():inner():goto_start():goto_end { key = ')' }
          tsto:set(',', 'parameter'):around():inner():goto_start():goto_end { key = '.' }
          tsto:set(';', 'statement'):around():inner({ attribute = 'outer' }):goto_start():goto_end { key = ':' }

          tsto
            :set('=', 'assignment')
            :around()
            :inner({ attribute = 'rhs' })
            :goto_start({ attribute = 'lhs' })
            :next_start({ attribute = 'rhs', key = '-' }, { desc = 'next assignment rhs' })
            :previous_start({ attribute = 'rhs', key = '-' }, { desc = 'previous assignment rhs' })

          tsto
            :set('c', 'class')
            :around()
            :inner()
            :next_start({ motion = ']', group_prefix = '', key = ']' })
            :next_end({ motion = ']', group_prefix = '', key = '[' })
            :previous_start({ motion = '[', group_prefix = '', key = '[' })
            :previous_end { motion = '[', group_prefix = '', key = ']' }
        end, { desc = 'Set keysitter keymaps for nvim-treesitter-textobjects' })
      end,
    },
  },
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  config = function()
    -- put your config here
    -- configuration
    require('nvim-treesitter-textobjects').setup {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          -- ['@function.outer'] = 'V', -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },

      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
    }
  end,
}
