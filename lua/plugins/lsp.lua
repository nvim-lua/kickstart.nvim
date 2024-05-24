return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'folke/neodev.nvim',
      { 'j-hui/fidget.nvim' },
    },
    config = function()
      require 'plugins.neodev'
      require('neoconf').setup {}

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

      local lazyPlugins = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
      local servers = {
        biome = {},
        tsserver = {},
        lua_ls = {
          settings = {
            lua = {
              runtime = {
                version = 'LuaJIT',
              },
              workspace = {
                checkthirdparty = { lazyPlugins },

                library = {
                  vim.env.VIMRUNTIME,
                  --   -- depending on the usage, you might want to add additional paths here.
                  --   -- "${3rd}/luv/library"
                  --   -- "${3rd}/busted/library",
                  -- },
                  -- or pull in all of 'runtimepath'. note: this is a lot slower
                },
                -- library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), { vim.env.VIMRUNTIME }),
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
        jsonls = {},
        yamlls = {},
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
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
    settings = {
      Lua = {},
    },
  },
}
