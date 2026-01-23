return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      setup = {
        ruff = function(_, _)
          -- This runs when ruff is being set up
          -- We can return true to skip default setup, but we don't want that
          -- Instead we hook later
        end,
      },
    },
    config = function()
      -- Hook into existing LspAttach (kickstart already created the group)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'ruff' then
            client.server_capabilities.diagnosticProvider = false
          end
        end,
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = false }),
      })
    end,
  },
}
