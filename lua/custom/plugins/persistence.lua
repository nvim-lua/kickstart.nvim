return {
  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>sS", function() require("persistence").select() end,desc = "[S]earch Previous [S]essions" },
      { "<leader>sR", function() require("persistence").load({ last = true }) end, desc = "Restore Last [S]ession" },
      { "<leader>sD", function() require("persistence").stop() end, desc = "Don't Save Current [S]ession" },
    },
  },

  -- library used by other plugins
  { 'nvim-lua/plenary.nvim', lazy = true },
}
