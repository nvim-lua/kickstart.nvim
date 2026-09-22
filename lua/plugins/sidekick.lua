return {
  {
    "folke/sidekick.nvim",
    cmd = "Sidekick",
    opts = {
      nes = { enabled = false },
      copilot = { status = { enabled = false } },
      cli = {
        mux = {
          backend = "zellij",
          enabled = vim.env.ZELLIJ ~= nil,
          create = "terminal",
        },
        tools = { codex = {} },
      },
    },
    keys = {
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end,
        desc = "Toggle Codex",
      },
    },
  },
}
