return {
  -- ========================================
  -- LSP Configuration Override (via mason-lspconfig)
  -- ========================================
  {
    'neovim/nvim-lspconfig',
    -- Define dependencies required by lspconfig and related features
    dependencies = {
      -- Mason must be loaded before mason-lspconfig
      { 'williamboman/mason.nvim', opts = {} }, -- Basic setup for mason
      {
        'williamboman/mason-lspconfig.nvim',
        -- This table defines the options for mason-lspconfig
        -- It tells mason-lspconfig which servers Mason should install.
        opts = {
          ensure_installed = {
            'lua_ls',
            'clangd',
            'pyright',
            'nil_ls',
            -- Add others like 'bashls', 'yamlls', 'nixd', 'gopls', 'rust_analyzer' etc. if needed
          },
        },
      },
      -- Optional: Tool installer for linters/formatters not handled by LSP
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

      -- LSP source for nvim-cmp (ensure this is also listed as dep for nvim-cmp)
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function(_, opts)
      -- This config function runs AFTER the plugin and its dependencies are loaded.
      -- It sets up the LSP servers based on the configurations provided.

      -- Get LSP capabilities, augmented by nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Call mason-lspconfig's setup function. This primarily ensures that the
      -- ensure_installed list above is processed by Mason for installation.
      -- We don't rely on this setup call to configure the servers below anymore.
      -- require('mason-lspconfig').setup(opts) -- This might not even be needed if opts are passed automatically

      -- Manually define the list of servers we want lspconfig to setup.
      -- This list should match the 'ensure_installed' list for mason-lspconfig above.
      local servers_to_setup = { 'lua_ls', 'clangd', 'pyright' } -- <-- EXPLICIT LIST HERE

      -- Iterate through the defined servers list and set them up with lspconfig
      for _, server_name in ipairs(servers_to_setup) do
        -- print('Setting up LSP server: ' .. server_name) -- Debug print
        require('lspconfig')[server_name].setup {
          capabilities = capabilities, -- Pass augmented capabilities
          -- Add any server-specific overrides here if needed
        }
      end

      -- Setup keymaps and diagnostics based on kickstart's original init.lua LSP section
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-override', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Standard LSP keymaps
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Highlight references
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, { bufnr = bufnr })
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end
          if client and client_supports_method(client, 'textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight-override', { clear = false })
            vim.api.nvim_create_autocmd(
              { 'CursorHold', 'CursorHoldI' },
              { buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.document_highlight }
            )
            vim.api.nvim_create_autocmd(
              { 'CursorMoved', 'CursorMovedI' },
              { buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.clear_references }
            )
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach-override', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight-override', buffer = event2.buf }
              end,
            })
          end

          -- Inlay hints toggle
          if client and client_supports_method(client, 'textDocument/inlayHint', event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
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

  -- lazydev setup
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } },
    },
  },
}
