return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        set_jumps = true,
      },
    }

    local move = require 'nvim-treesitter-textobjects.move'

    vim.keymap.set('n', '<leader>jm', function()
      move.goto_next_start '@function.outer'
    end, { desc = '[J]ump next [M]ethod start' })

    vim.keymap.set('n', '<leader>jM', function()
      move.goto_next_end '@function.outer'
    end, { desc = '[J]ump next [M]ethod end' })

    vim.keymap.set('n', '<leader>jk', function()
      move.goto_previous_start '@function.outer'
    end, { desc = '[J]ump previous method start' })

    vim.keymap.set('n', '<leader>jK', function()
      move.goto_previous_end '@function.outer'
    end, { desc = '[J]ump previous method end' })

    vim.keymap.set('n', '<leader>jc', function()
      move.goto_next_start '@class.outer'
    end, { desc = '[J]ump next [C]lass start' })

    vim.keymap.set('n', '<leader>jC', function()
      move.goto_previous_start '@class.outer'
    end, { desc = '[J]ump previous class start' })
  end,
}
