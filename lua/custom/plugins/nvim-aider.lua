return {
  {
    'GeorgesAlkhouri/nvim-aider',
    cmd = 'Aider',
    -- Example key mappings for common actions:
    keys = {
      { '<leader>i/', '<cmd>Aider toggle<cr>', desc = 'Toggle Aider' },
      { '<leader>is', '<cmd>Aider send<cr>', desc = 'Send to Aider', mode = { 'n', 'v' } },
      { '<leader>ic', '<cmd>Aider command<cr>', desc = 'Aider Commands' },
      { '<leader>ib', '<cmd>Aider buffer<cr>', desc = 'Send Buffer' },
      { '<leader>i+', '<cmd>Aider add<cr>', desc = 'Add File' },
      { '<leader>i-', '<cmd>Aider drop<cr>', desc = 'Drop File' },
      { '<leader>ir', '<cmd>Aider add readonly<cr>', desc = 'Add Read-Only' },
      { '<leader>iR', '<cmd>Aider reset<cr>', desc = 'Reset Session' },
    },
    dependencies = {
      'folke/snacks.nvim',
      --- The below dependencies are optional
      --- Neo-tree integration
      {
        'nvim-neo-tree/neo-tree.nvim',
        opts = function(_, opts)
          -- Example mapping configuration (already set by default)
          -- opts.window = {
          --   mappings = {
          --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
          --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
          --     ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" }
          --   }
          -- }
          require('nvim_aider.neo_tree').setup(opts)
        end,
      },
    },
    config = true,
    opts = {
      auto_reload = true,
    },
    init = function()
      local wk = require 'which-key'
      wk.add {
        { '<leader>i', group = 'A[i]der commands' },
      }
    end,
  },
}
