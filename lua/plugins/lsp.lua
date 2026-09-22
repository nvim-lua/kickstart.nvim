local function optional_require(name)
  local ok, module = pcall(require, name)
  return ok and module or nil
end

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    },
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = { "folke/lazydev.nvim" },
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          local function map(lhs, rhs, desc, mode)
            vim.keymap.set(mode or "n", lhs, rhs, {
              buffer = event.buf,
              desc = "LSP: " .. desc,
            })
          end

          local telescope = require("telescope.builtin")
          map("gn", vim.lsp.buf.rename, "Rename")
          map("ga", vim.lsp.buf.code_action, "Code action", { "n", "x" })
          map("gr", telescope.lsp_references, "References")
          map("gi", telescope.lsp_implementations, "Implementation")
          map("gd", telescope.lsp_definitions, "Definition")
          map("gD", vim.lsp.buf.declaration, "Declaration")
          map("gO", telescope.lsp_document_symbols, "Document symbols")
          map("gW", telescope.lsp_dynamic_workspace_symbols, "Workspace symbols")
          map("gt", telescope.lsp_type_definitions, "Type definition")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), {
                bufnr = event.buf,
              })
            end, "Toggle inlay hints")
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = { source = "if_many", spacing = 2 },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        pyright = {},
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
        },
        rust_analyzer = {},
        ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              completion = { callSnippet = "Replace" },
            },
          },
        },
      }

      local overrides = optional_require("local.overrides") or {}
      servers = vim.tbl_deep_extend("force", servers, overrides.lsp or {})

      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
        vim.lsp.config(name, config)
      end

      local ensure_installed = vim.tbl_keys(servers)
      table.sort(ensure_installed)
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_enable = ensure_installed,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>f",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "x" },
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = { inlay_hints = { inline = true } },
    keys = {
      {
        "<leader>ch",
        "<cmd>ClangdSwitchSourceHeader<CR>",
        ft = { "c", "cpp" },
        desc = "Switch C/C++ header and source",
      },
    },
  },
}
