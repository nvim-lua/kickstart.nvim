-- ~/dlond/nvim/lua/custom/plugins/lsp.lua
-- LSP configuration, assuming LSP servers are installed via Nix/Home Manager

return {
  -- ========================================
  -- LSP Configuration (LSP servers provided by Nix/Home Manager)
  -- ========================================
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' }, -- Load LSP config early
    dependencies = {
      -- Dependencies for nvim-lspconfig itself, if any.
      -- Mason and mason-lspconfig are removed as Nix handles LSP installation.
      { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP
      'hrsh7th/cmp-nvim-lsp', -- LSP completion source for nvim-cmp
    },
    config = function(_, opts)
      -- This config function runs AFTER the plugin and its dependencies are loaded.
      -- It sets up the LSP servers.

      -- Load Nix-provided paths from the generated Lua file
      package.loaded['custom.nix_paths'] = nil
      local nix_paths_status, nix_paths = pcall(require, 'custom.nix_paths')
      if not nix_paths_status then
        vim.notify('Error loading custom.nix_paths: ' .. (nix_paths or 'Unknown error'), vim.log.levels.ERROR)
        nix_paths = {} -- Provide an empty table to avoid further errors
      end

      print('DEBUG: nix_paths content: ' .. vim.inspect(nix_paths))

      -- Get LSP capabilities, augmented by nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Define the list of LSP servers you want to configure.
      -- These servers must be installed via Nix/Home Manager and be in your PATH.
      local servers = {
        lua_ls = {
          -- cmd = { ... }
          -- filetypes = { ... }
          -- capabilities = {}
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        clangd = {
          cmd = (function()
            if nix_paths.clang_driver_path then
              return {
                'clangd',
                '--query-driver=' .. nix_paths.clang_driver_path,
              }
            else
              vim.notify('Warning: Nix path for clang_driver_path not defined. clangd might not work correctly.', vim.log.levels.WARN)
              return { 'clangd' } -- Fallback
            end
          end)(),
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'basic',
              },
            },
            positionEncoding = 'utf-8',
          },
        },
        nixd = {},
        ruff = {},
        -- Add other servers like "bashls", "yamlls", "gopls", "rust_analyzer" etc.
        -- Ensure the corresponding packages (e.g., pkgs.bash-language-server)
        -- are in your Home Manager home.packages list.
      }
      print('DEBUG: servers table content: ' .. vim.inspect(servers))

      local first_key, first_value = next(servers)
      print('DEBUG: next(servers) returned key: ' .. tostring(first_key) .. ', value: ' .. vim.inspect(first_value))
      if first_key == nil then
        print "DEBUG: The 'servers' table is effectively empty for iteration with pairs()."
      else
        print "DEBUG: The 'servers' table is NOT empty for iteration."
      end

      -- Iterate through the defined servers list and set them up with lspconfig
      print 'LSPConfig: Iterating servers...'
      for server_name, server_config_override in ipairs(servers) do
        print('Attempting to set up LSP server: ' .. server_name) -- Debug print
        local server_ops = {
          capabilities = capabilities,
        }
        server_ops = vim.tbl_deep_extend('force', server_ops, server_config_override or {})
        local setup_ok, setup_err = pcall(require('lspconfig')[server_name].setup, server_ops)
        if not setup_ok then
          vim.notify("Error setting up LSP server '" .. server_name .. "': " .. tostring(setup_err), vim.log.levels.ERROR)
          print('LSPConfig ERROR for ' .. server_name .. ': ' .. tostring(setup_err)) -- DEBUG
        else
          print('LSPConfig: Successfully called setup for: ' .. server_name) -- DEBUG
        end
        -- require('lspconfig')[server_name].setup(server_ops)
      end
      print 'LSPConfig: Finished iterating servers.'

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

  -- lazydev setup (still useful for Neovim Lua development)
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } },
    },
  },
}
