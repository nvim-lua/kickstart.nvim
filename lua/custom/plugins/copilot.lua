return {
  {
    "zbirenbaum/copilot.lua",
    verylazy = true,
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  { 'AndreM222/copilot-lualine' },
}
