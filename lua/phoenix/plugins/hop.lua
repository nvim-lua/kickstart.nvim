return {
  "phaazon/hop.nvim",
  config = function()
    require("hop").setup {
      keys = "arstgmneiodh",
    }
    vim.keymap.set("n", "<C-e>", "<cmd>lua require'hop'.hint_words()<cr>", { noremap = true, silent = true })
  end
}
