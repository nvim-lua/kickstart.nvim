return {
  "waltr-fr/redalert.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("redalert").setup({
      cutoff_days = 5,
    })
  end,
}
