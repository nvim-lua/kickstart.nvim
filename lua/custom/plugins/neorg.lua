return {
  {
    "nvim-neorg/neorg",
    version = "*",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              general = "$XDG_DOCUMENTS_DIR/neorg/general",
            },
            default_workspace = "general",
          },
        },
      },
    },
    config = function()
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  }
}
