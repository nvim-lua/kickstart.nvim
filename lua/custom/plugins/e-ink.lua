return {
   "alexxGmZ/e-ink.nvim",
   priority = 1000,
   config = function ()
      require("e-ink").setup()
      vim.cmd.colorscheme "e-ink"

      -- choose light mode or dark mode
      -- vim.opt.background = "dark"
      vim.opt.background = "light"
      --
      -- or do
      -- :set background=dark
      -- :set background=light
   end
}
