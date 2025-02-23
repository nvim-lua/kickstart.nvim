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
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
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

    -- Setup neovim lua configuration
    -- require('neodev').setup({
    --   library = {
    --     enabled = true,
    --     runtime = true,
    --     types = true,
    --     plugins = true,
    --   },
    -- })

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          settings = servers[server_name] and servers[server_name].settings or {},
          filetypes = servers[server_name] and servers[server_name].filetypes,
        }
      end,
    }

    -- Single LSP attach handler for all functionality
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(args)
        -- Remove any diagnostic keymaps
        pcall(vim.keymap.del, 'n', '<leader>e', { buffer = args.buf })

        -- Get the client
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

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
  end,
}
