-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = '[A]round a [F]unction' },
            ['if'] = { query = '@function.inner', desc = '[I]nside a [F]unction' },
            ['ac'] = { query = '@class.outer', desc = '[A]round of [C]lass' },
            ['a]'] = { query = '@class.outer', desc = '[A]round of Class' },
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ['ic'] = { query = '@class.inner', desc = '[I]nner part of [C]lass' },
            ['i]'] = { query = '@class.inner', desc = '[I]nner part of Class' },
            -- You can also use captures from other query groups like `locals.scm`
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>cpa'] = { query = '@parameter.inner', desc = '[C]ode [P]arameter [A]djust Next' },
          },
          swap_previous = {
            ['<leader>cpA'] = { query = '@parameter.inner', desc = '[C]ode [P]arameter [A]djust Previous' },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = { query = '@function.outer', desc = 'Next [F]unction Start' },
            [']]'] = { query = '@class.outer', desc = 'Next Class Start' },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
            [']o'] = '@loop.*',
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next [S]cope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next Fold' },
          },
          goto_next_end = {
            [']F'] = { query = '@function.outer', desc = 'Next [F]unction End' },
            [']['] = { query = '@class.outer', desc = 'Next Class End' },
          },
          goto_previous_start = {
            ['[f'] = { query = '@function.outer', desc = 'Previous [F]unction Start' },
            ['[['] = { query = '@class.outer', desc = 'Previous Class Start' },
          },
          goto_previous_end = {
            ['[F'] = { query = '@function.outer', desc = 'Previous [F]unction End]' },
            ['[]'] = { query = '@class.outer', desc = 'Previous Class End' },
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            [']c'] = { query = '@conditional.outer', desc = 'Next [C]onditional' },
          },
          goto_previous = {
            ['[c'] = { query = '@conditional.outer', desc = 'Previous [C]onditional]' },
          },
        },
      },
    }

    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

    -- example: make gitsigns.nvim movement repeatable with ; and , keys.
    local gs = require 'gitsigns'

    -- make sure forward function comes first
    local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
    -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

    vim.keymap.set({ 'n', 'x', 'o' }, ']h', next_hunk_repeat)
    vim.keymap.set({ 'n', 'x', 'o' }, '[h', prev_hunk_repeat)
  end,
}
