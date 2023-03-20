return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local codeActions = null_ls.builtins.code_actions

    local sources = {
      formatting.eslint_d, formatting.prettierd.with({
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn
              .expand "~/.config/nvim/utils/linter-config/.prettierrc.js"
        }
      }), -- formatting.prettier
      --     .with({extra_args = {'--single-quote', '--tab-width 2', '--arrow-parens avoid'}}),
      formatting.lua_format.with({
        extra_args = {
          '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
          '--break-after-table-lb', '--indent-width=2'
        }
      }), diagnostics.eslint_d.with({diagnostics_format = "[#{c}] #{m} (#{s})"}),
      codeActions.eslint_d
    }

    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        -- async = true,
        filter = function(client)
          -- apply whatever logic you want (in this example, we'll only use null-ls)
          return client.name == "null-ls"
        end,
        bufnr = bufnr
      })
    end

    -- if you want to set up formatting on save, you can use this as a callback
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
      -- if client.name == "tsserver" or client.name == "cssls" or client.name == "html" then
      --   client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
      -- end
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end
        })
      end
    end

    null_ls.setup({sources = sources, debug = true, on_attach = on_attach})
  end
}
