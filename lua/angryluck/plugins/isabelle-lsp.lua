return {
  {
    "Treeniks/isabelle-lsp.nvim",
    branch = "isabelle-language-server",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("isabelle-lsp").setup({
        isabelle_path = "/home/angryluck/isabelle-lsp/isabelle-emacs/bin/isabelle",
      })
      local lspconfig = require("lspconfig")
      lspconfig.isabelle.setup({})
    end,
  },
  "Treeniks/isabelle-syn.nvim",
}
