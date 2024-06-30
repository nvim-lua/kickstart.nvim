return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'folke/lazydev.nvim',
      'b0o/schemastore.nvim',
      { 'j-hui/fidget.nvim' },
    },
    config = function()
      require('lazydev').setup {}
      vim.diagnostic.config {
        update_in_insert = true,
        float = {
          focusable = false,
        },
        signs = true,
        underline = true,
        virtual_text = false,
        severity_sort = true,
      }

      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.callHierarchy.dynamicRegistration = true

      local lazyPlugins = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
      local servers = {
        biome = {
          settings = {
            biome = {
              single_file_support = true,
            },
          },
        },
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
                pathStrict = true,
                path = { '?.lua', '?/init.lua' },
              },
              workspace = {
                checkThirdParty = false,
                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), { vim.env.VIMRUNTIME }),
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = {
                disable = { 'missing-fields' },
                globals = { 'vim' },
              },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = {
                enable = true,
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = require('schemastore').yaml.schemas(),
            },
            schemaStore = {
              enable = true,
            },
          },
        },
        eslint_d = {},
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  ignore = { 'W391' },
                  maxLineLength = 120,
                },
              },
            },
          },
        },
      }

      --  You can press `g?` for help in this menu.
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
