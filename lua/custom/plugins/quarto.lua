return {
  {
    'quarto-dev/quarto-nvim',
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = 'curly',
      },
      codeRunner = {
        enabled = true,
        default_method = 'slime',
      },
    },
    config = function()
      local runner = require 'quarto.runner'
      vim.keymap.set('n', '<C-c>c', runner.run_cell, { desc = 'run cell', silent = true })
      vim.keymap.set('n', '<C-c>a', runner.run_above, { desc = 'run cell and above', silent = true })
      vim.keymap.set('n', '<C-c>A', runner.run_all, { desc = 'run all cells', silent = true })
      vim.keymap.set('n', '<C-c>l', runner.run_line, { desc = 'run line', silent = true })
      vim.keymap.set('v', '<C-c>r', runner.run_range, { desc = 'run visual range', silent = true })
      -- vim.keymap.set('n', '<C-c>RA', function()
      --   runner.run_all(true)
      -- end, { desc = 'run all cells of all languages', silent = true })
    end,
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  {
    'jpalardy/vim-slime',
    dev = false,
    init = function()
      vim.g.slime_target = 'tmux'
      -- vim.g.slime_default_config = {"socket_name" = "default", "target_pane" = "{last}"}
      vim.g.slime_default_config = {
        -- Lua doesn't have a string split function!
        socket_name = vim.api.nvim_eval 'get(split($TMUX, ","), 0)',
        target_pane = '{bottom}',
      }
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true
      vim.b.slime_cell_delimiter = '```'
      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print('job_id: ' .. job_id)
      end

      local function set_terminal()
        vim.fn.call('slime#config', {})
      end
      vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
      vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })
    end,
  },
}
