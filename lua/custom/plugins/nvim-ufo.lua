return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      for _, client in pairs(vim.lsp.get_clients()) do
        client.server_capabilities.foldingRangeProvider = true
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.server_capabilities.foldingRangeProvider = true
          end
        end,
      })

      require("ufo").setup({
        provider_selector = function(_, _, _)
          return { "lsp", "indent" }
        end,
      })
    end,
  },
}

