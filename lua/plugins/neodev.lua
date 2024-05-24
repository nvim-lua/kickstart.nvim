return {
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = true,
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
      },
      setup_jsonls = true,
      lspconfig = true,
      pathStrict = true,
    },
  },
}
