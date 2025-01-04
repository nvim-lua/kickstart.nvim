return {
  {
    "zbirenbaum/copilot.lua",
    verylazy = true,
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup()
    end
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {},
  },

  { 'AndreM222/copilot-lualine' },
}
