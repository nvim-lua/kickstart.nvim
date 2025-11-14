-- lua/plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- load early so it can attach
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
    "nvimtools/none-ls-extras.nvim", -- required for eslint_d now
  },
  config = function()
    local null_ls = require("null-ls")

    -- eslint_d now comes from none-ls-extras, NOT null_ls.builtins
    local eslint_d = require("none-ls.diagnostics.eslint_d")

    null_ls.setup({
      sources = {
        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.golines,        -- optional
        null_ls.builtins.diagnostics.golangci_lint, -- if installed

        -- Web
        null_ls.builtins.formatting.prettierd,
        eslint_d,
      },
    })

    require("mason-null-ls").setup({
      ensure_installed = { "gofumpt", "golines", "golangci-lint", "prettierd", "eslint_d" },
      automatic_installation = true,
      -- leaving automatic_setup at default (false) so it doesn't double-register sources
    })

    -- (optional) format on save for Go
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}

