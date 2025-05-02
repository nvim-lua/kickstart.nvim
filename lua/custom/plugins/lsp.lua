-- LSP configuration override

return {
  {
    'neovim/nvim-lspconfig',
    -- Define dependencies required by lspconfig and related features
    dependencies = {
      -- Mason must be loaded before mason-lspconfig
      { 'williamboman/mason.nvim', opts = {} }, -- Basic setup for mason
      {
        'williamboman/mason-lspconfig.nvim',
        -- This table overrides the `ensure_installed` option for mason-lspconfig
        opts = {
          ensure_installed = {
            -- List ALL servers you want mason-lspconfig to manage installation for
            'lua_ls', -- Keep kickstart default
            'clangd', -- Your addition
            'pyright', -- Your addition
            -- Add others like 'bashls', 'yamlls', 'nixd', 'gopls', 'rust_analyzer' etc. if needed
          },
          -- You can add other mason-lspconfig options here if needed
          -- automatic_installation = true, -- Example: if you want auto-install
        },
      },
      -- Optional: Tool installer for linters/formatters not handled by LSP
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim', -- If you use it, configure its ensure_installed separately

      -- Status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

      -- LSP source for nvim-cmp (ensure this is also listed as dep for nvim-cmp)
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function(_, opts)
      -- This config function runs AFTER the plugin and its dependencies are loaded.
      -- It sets up the LSP servers based on the configurations provided.

      -- Get LSP capabilities from nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Setup LSP servers using mason-lspconfig
      -- This iterates through the servers listed in `ensure_installed` above
      -- and calls lspconfig's setup function for each.
      require('mason-lspconfig').setup_handlers {
        function(server_name) -- Default handler
          require('lspconfig')[server_name].setup {
            capabilities = capabilities, -- Pass cmp capabilities to the server
            -- Add any server-specific overrides here if needed, e.g.:
            -- on_attach = function(client, bufnr) ... end,
            -- settings = { ... },
          }
        end,
        -- Example of specific setup for a server if needed:
        -- ['lua_ls'] = function()
        --   require('lspconfig').lua_ls.setup {
        --     capabilities = capabilities,
        --     settings = { Lua = { completion = { callSnippet = 'Replace' } } },
        --   }
        -- end,
      }

      -- Setup keymaps and diagnostics based on kickstart's original init.lua LSP section
      -- This ensures the standard LSP keymaps (gd, gr, etc.) are set on attach.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-override', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Standard LSP keymaps (copy these from kickstart init.lua or customize)
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Highlight references (optional, from kickstart)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method 'textDocument/documentHighlight' then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight-override', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            -- Ensure highlight group is cleared on detach
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach-override', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight-override', buffer = event2.buf }
              end,
            })
          end

          -- Inlay hints toggle (optional, from kickstart)
          if client and client.supports_method 'textDocument/inlayHint' then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic configuration (can be kept from kickstart or customized)
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font
            and {
              text = {
                [vim.diagnostic.severity.ERROR] = '󰅚 ', -- Error icon
                [vim.diagnostic.severity.WARN] = '󰀪 ', -- Warning icon
                [vim.diagnostic.severity.INFO] = '󰋽 ', -- Info icon
                [vim.diagnostic.severity.HINT] = '󰌶 ', -- Hint icon
              },
            }
          or {}, -- Use kickstart's sign definitions
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            -- Map diagnostic severity to the message itself (simple format)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
    end, -- End of config function
  },

  -- Add the lazydev setup here as well, as it relates to LSP for Lua development
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } }, -- Corrected path if using luvit types
      },
    },
  },
}
