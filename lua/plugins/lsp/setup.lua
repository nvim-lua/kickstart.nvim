---@diagnostic disable: undefined-global
-- LSP setup (mason + lspconfig)

local M = {}

function M.setup()
  -- Apply LSP function overrides for position_encoding
  require('plugins.lsp.overrides').setup()
  
  local servers = require('plugins.lsp.servers')
  
  -- Enhanced nvim-cmp capabilities (VSCode-like)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { 'markdown', 'plaintext' },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      },
    },
  }
  -- Complete with all available methods and properties
  capabilities.textDocument.completion.completionList = {
    itemDefaults = {
      'commitCharacters',
      'editRange',
      'insertTextFormat',
      'insertTextMode',
      'data',
    },
  }
  -- Add semantic tokens for better syntax highlighting
  capabilities.textDocument.semanticTokens = {
    tokenTypes = { 'namespace', 'type', 'class', 'enum', 'interface', 'struct', 'typeParameter', 'parameter', 'variable', 'property', 'enumMember', 'event', 'function', 'method', 'macro', 'keyword', 'modifier', 'comment', 'string', 'number', 'regexp', 'operator', 'decorator' },
    tokenModifiers = { 'declaration', 'definition', 'readonly', 'static', 'deprecated', 'abstract', 'async', 'modification', 'documentation', 'defaultLibrary' },
    formats = { 'relative' },
    requests = {
      range = true,
      full = true,
    },
  }
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Setup mason-lspconfig with handlers
  local mason_lspconfig = require('mason-lspconfig')
  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    handlers = {
      function(server_name)
      local config = servers[server_name] or {}
      config.capabilities = capabilities

      -- Default on_attach to setup keymaps & navic
      M.default_on_attach = function(client, bufnr)
        require('core.keymaps').setup_lsp_keymaps(bufnr)
        
        -- Only attach navic if:
        -- 1. The client supports document symbols
        -- 2. The client isn't elixirls (handled by elixir-tools.nvim)
        if client.server_capabilities.documentSymbolProvider 
            and client.name ~= 'elixirls' then
          local status_ok, _ = pcall(require, 'nvim-navic')
          if status_ok then
            require('nvim-navic').attach(client, bufnr)
          end
        end
      end
      
      -- Only set the default on_attach if one isn't already provided
      if not config.on_attach then
        config.on_attach = M.default_on_attach
      end

      -- Enhance LSP capabilities for specific servers
      if server_name == 'gopls' and config.on_attach then
        local orig_on_attach = config.on_attach
        config.on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
          orig_on_attach(client, bufnr)
        end
      end
      
      -- Force all LSP servers to use incremental completions (like VSCode)
      if not config.settings then config.settings = {} end
      if not config.settings.completions then config.settings.completions = {} end
      config.settings.completions.completeFunctionCalls = true
      
      -- Enhanced settings for Lua LSP
      if server_name == 'lua_ls' then
        if not config.settings.Lua then config.settings.Lua = {} end
        config.settings.Lua.completion = {
          callSnippet = "Replace",
          showWord = "Disable",
          workspaceWord = false,
          displayContext = 5,
          keywordSnippet = "Both",
          postfix = ".",
        }
        -- More comprehensive inferencing
        config.settings.Lua.hint = {
          enable = true,
          setType = true,
          paramType = true,
          paramName = "Literal",
          arrayIndex = "Enable",
        }
        -- Better type resolution
        config.settings.Lua.type = {
          castNumberToInteger = true,
        }
        -- Add standard Lua libraries for better completion
        if not config.settings.Lua.workspace then config.settings.Lua.workspace = {} end
        if not config.settings.Lua.workspace.library then config.settings.Lua.workspace.library = {} end
        
        -- Include standard libraries
        local lua_types = vim.fn.expand('~/.local/share/nvim/mason/packages/lua-language-server/libexec/meta/3rd')
        if vim.fn.isdirectory(lua_types) == 1 then
          config.settings.Lua.workspace.library[lua_types] = true
        end
        -- Enable all features
        config.settings.Lua.hover = { enable = true, expandAlias = true }
        config.settings.Lua.signatureHelp = { enable = true }
        config.settings.Lua.diagnostics = { enable = true, globals = { "vim" } }
      end

      require('lspconfig')[server_name].setup(config)
    end,
    },
  }

  -- Hover handler will now be provided by Blink
  
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
