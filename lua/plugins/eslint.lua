return {
  {
    "neovim/nvim-lspconfig",
    -- other settings removed for brevity
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
          require("lazyvim.util").on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
        --   eslint = function()
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --       callback = function(event)
        --         local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
        --         if client then
        --           local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
        --           if #diag > 0 then
        --             vim.cmd("EslintFixAll")
        --           end
        --         end
        --       end,
        --     })
        --   end,
      },
    },
  },
}
