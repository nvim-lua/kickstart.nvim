---@diagnostic disable: undefined-global
-- LSP setup (mason + lspconfig)

local M = {}

function M.setup()
  local servers = require('plugins.lsp.servers')
  
  -- nvim-cmp capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Setup mason-lspconfig
  local mason_lspconfig = require('mason-lspconfig')
  mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }

  mason_lspconfig.setup_handlers {
    function(server_name)
      local config = servers[server_name] or {}
      config.capabilities = capabilities

      -- Default on_attach to setup keymaps & navic
      local function on_attach(client, bufnr)
        require('core.keymaps').setup_lsp_keymaps(bufnr)
        -- Attach navic if available
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
      end
      config.on_attach = on_attach

      -- Disable gopls semantic tokens to avoid issues
      if server_name == 'gopls' and config.on_attach then
        local orig_on_attach = config.on_attach
        config.on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
          orig_on_attach(client, bufnr)
        end
      end

      require('lspconfig')[server_name].setup(config)
    end,
  }

  -- Override references handler
  vim.lsp.handlers['textDocument/references'] = function(err, result, ctx, config)
    if not result or vim.tbl_isempty(result) then
      vim.notify('No references found', vim.log.levels.INFO)
    else
      require('telescope.builtin').lsp_references()
    end
  end

  -- Override semanticTokens/full
  vim.lsp.handlers['textDocument/semanticTokens/full'] = function(err, result, ctx, cfg)
    if err or not result then return end
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then return end
    local bufnr = ctx.bufnr
    local highlighter = vim.lsp.semantic_tokens.create_highlighter(bufnr, client)
    if not highlighter then return end
    pcall(function()
      highlighter:process_response(result, client, ctx.request.version)
    end)
  end
end

return M
