return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    -- modes = {
    --   diagnostics = {
    --     filter = {
    --       severity = { min = vim.diagnostic.severity.WARN }, -- WARN + ERROR
    --     },
    --   },
    -- },
  },
  keys = {
    {
      "<leader>ss",
      function()
        require("trouble").toggle("diagnostics") -- or open/close depending on state
        -- if you want to always focus:
        -- require("trouble").open({ mode = "diagnostics", focus = true })
      end,
      desc = "Diagnostics (Trouble)",
      mode = "n",
    },
  },
}

