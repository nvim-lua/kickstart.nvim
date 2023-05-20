return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "svelte-language-server")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {},
      },
    },
  },
  "evanleck/vim-svelte",
}
