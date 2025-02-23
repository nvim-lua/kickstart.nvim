return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    -- 'folke/neodev.nvim',  -- Adds support for Neovim Lua API -- No longer needed with lazydev
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      config = function()
        require('mason-tool-installer').setup {
          ensure_installed = {
            'lua-language-server',
            'marksman',
            -- Go tools
            'gopls',           -- Go LSP
            'gofumpt',         -- Stricter Go formatter
            'goimports',       -- Go import manager
            'golangci-lint',   -- Go linter
            'delve',           -- Go debugger
            -- Zig tools
            'zls',             -- Zig LSP
            -- C tools
            'clangd',          -- C/C++ LSP
            'clang-format',    -- C/C++ formatter
            'codelldb',        -- Native code debugger
            -- Python tools
            'pyright',         -- Python LSP
            'black',           -- Python formatter
            'ruff',           -- Python linter
            'debugpy',        -- Python debugger
            -- SQL tools
            'sqls',            -- Advanced SQL LSP
          },
          auto_update = true,
          run_on_start = true,
        }
      end,
    },

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- See `:help lsp` for more details.

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed to the server. Can be used to disable diagnostics.
    local servers = {
      -- Python
      pyright = {},
      -- Go
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = false,  -- Let golangci-lint handle this
            gofumpt = false,     -- Let null-ls handle this
            hints = {
              assignVariableTypes = false,    -- Disable hints for better performance
              compositeLiteralFields = false,
              compositeLiteralTypes = false,
              constantValues = false,
              functionTypeParameters = false,
              parameterNames = false,
              rangeVariableTypes = false,
            },
            vulncheck = "Off",  -- Disable vulnerability checking
            completionBudget = "100ms",  -- Limit completion time
            symbolMatcher = "FastFuzzy",  -- Faster symbol matching
            symbolStyle = "Dynamic",
            usePlaceholders = false,  -- Disable placeholders for better performance
            matcher = "Fuzzy",  -- Faster matching algorithm
            diagnosticsDelay = "500ms",  -- Add slight delay to batch diagnostics
          },
        },
      },
      -- Lua
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
              },
            },
          },
        },
      },
      -- SQL - Advanced SQL language server with better completion
      sqls = {
        settings = {
          sqls = {
            connections = {}, -- Will be populated by dadbod
            lowercaseKeywords = true, -- Format keywords to lowercase
          },
        },
      },
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Single LSP attach handler for all functionality
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(args)
        -- Remove any diagnostic keymaps
        pcall(vim.keymap.del, 'n', '<leader>e', { buffer = args.buf })

        -- Get the client
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        -- Disable semantic tokens for gopls
        if client.name == "gopls" then
          client.server_capabilities.semanticTokensProvider = nil
        end

        -- Only set up document formatting for null-ls
        if client.name ~= "null-ls" then
          client.server_capabilities.documentFormattingProvider = false
        end

        -- Set up LSP keymaps
        require('core.keymaps').setup_lsp_keymaps(args.buf)

        -- Override the built-in LSP handler for references to use telescope
        vim.lsp.handlers['textDocument/references'] = function(_, result, ctx)
          if not result or vim.tbl_isempty(result) then
            vim.notify('No references found')
          else
            require('telescope.builtin').lsp_references()
          end
        end

        -- Set up document highlight on hover only if the server supports it
        if client.server_capabilities.documentHighlightProvider then
          local highlight_group = vim.api.nvim_create_augroup('lsp_document_highlight_' .. args.buf, { clear = true })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = highlight_group,
            buffer = args.buf,
            callback = function()
              -- Check if the client is still attached and valid
              if vim.lsp.buf_get_clients(args.buf)[1] then
                vim.lsp.buf.document_highlight()
              end
            end,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = highlight_group,
            buffer = args.buf,
            callback = function()
              -- Check if the client is still attached and valid
              if vim.lsp.buf_get_clients(args.buf)[1] then
                vim.lsp.buf.clear_references()
              end
            end,
          })
        end
      end,
    })

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- Custom semantic tokens handler for gopls
    local semantic_tokens_handler = function(err, result, ctx, config)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if not client then return end

      -- Check if client has the required semantic tokens capabilities
      local semantic_tokens = client.server_capabilities.semanticTokensProvider
      if not semantic_tokens or not semantic_tokens.legend then
        -- If no legend is provided, disable semantic tokens for this client
        client.server_capabilities.semanticTokensProvider = nil
        return
      end

      -- If we have a valid legend, proceed with default handler
      vim.lsp.semantic_tokens.on_full(err, result, ctx, config)
    end

    mason_lspconfig.setup_handlers {
      function(server_name)
        local server_config = servers[server_name] or {}
        
        -- For gopls, add debug logging
        if server_name == "gopls" then
          -- Create a custom on_attach that disables semantic tokens
          local orig_on_attach = server_config.on_attach
          server_config.on_attach = function(client, bufnr)
            -- Disable semantic tokens for this client
            client.server_capabilities.semanticTokensProvider = nil
            -- Call original on_attach if it exists
            if orig_on_attach then
              orig_on_attach(client, bufnr)
            end
          end
        end
        
        server_config.capabilities = capabilities
        require('lspconfig')[server_name].setup(server_config)
      end,
    }

    -- Override the semantic tokens handler to be more resilient
    vim.lsp.handlers['textDocument/semanticTokens/full'] = function(err, result, ctx, config)
      -- If there's an error or no result, just return
      if err or not result then return end

      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if not client then return end

      local bufnr = ctx.bufnr
      if not bufnr then return end

      -- Get the highlighter safely
      local highlighter = vim.lsp.semantic_tokens.create_highlighter(bufnr, client)
      if not highlighter then return end

      -- Process the response safely
      pcall(function()
        highlighter:process_response(result, client, ctx.request.version)
      end)
    end
  end,
}
