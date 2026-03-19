return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  -- init = function()
  --   -- Disable entire built-in ftplugin mappings to avoid conflicts.
  --   -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
  --   vim.g.no_plugin_maps = true
  --
  --   -- Or, disable per filetype (add as you like)
  --   -- vim.g.no_python_maps = true
  --   -- vim.g.no_ruby_maps = true
  --   -- vim.g.no_rust_maps = true
  --   -- vim.g.no_go_maps = true
  -- end,
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

    local select = require 'nvim-treesitter-textobjects.select'
    local move = require 'nvim-treesitter-textobjects.move'

    -- One-place defined treesitter-textobjects
    local ts_to = {
      ['b'] = 'block',
      ['c'] = 'class',
      ['f'] = 'function',
      ['i'] = 'conditional',
      ['l'] = 'loop',
      ['m'] = 'comment',
      ['p'] = 'parameter',
      ['r'] = 'return',
    }

    -- Set a _leader_ key to put all treesitter-textobjects under one prefix
    -- I set this for:
    --   - avoid conflict. (it's better than setting vim.g.no_plugin_maps = false)
    --   - experimenting with other plugins like mini.ai and mini.move
    local ldr = 'o'

    for k, o in pairs(ts_to) do
      local outer = '@' .. o .. '.outer'
      local inner = '@' .. o .. '.inner'

      -- [a]round/[i]nner
      vim.keymap.set({ 'x', 'o' }, 'a' .. ldr .. k, function()
        select.select_textobject(outer, 'textobjects')
      end, { desc = 'arround ' .. o })
      vim.keymap.set({ 'x', 'o' }, 'i' .. ldr .. k, function()
        select.select_textobject(inner, 'textobjects')
      end, { desc = 'inner ' .. o })

      -- jump next] / previous[
      vim.keymap.set({ 'n', 'x', 'o' }, ']' .. ldr .. k, function()
        move.goto_next_start(outer, 'textobjects')
      end, { desc = 'next ' .. o .. ' start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']' .. ldr .. k:upper(), function()
        move.goto_next_end(outer, 'textobjects')
      end, { desc = 'next ' .. o .. ' end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[' .. ldr .. k, function()
        move.goto_previous_start(outer, 'textobjects')
      end, { desc = 'previous ' .. o .. ' start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[' .. ldr .. k:upper(), function()
        move.goto_previous_end(outer, 'textobjects')
      end, { desc = 'previous ' .. o .. ' end' })
    end
  end,
}
