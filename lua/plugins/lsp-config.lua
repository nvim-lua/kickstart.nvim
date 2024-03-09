return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "angularls", "ansiblels", "clangd", "cssls", "cssmodules_ls", "unocss", "diagnosticls", "dockerls", "docker_compose_language_service", "eslint", "golangci_lint_ls", "gopls", "grammarly", "graphql", "html", "helm_ls", "jsonls", "biome", "tsserver", "sqlls", "tailwindcss", "templ", "terraformls", "tflint", "yamlls" },
      }
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      lspconfig.lua_ls.setup({capabilities = capabilities})
      lspconfig.angularls.setup({capabilities = capabilities})
      lspconfig.ansiblels.setup({capabilities = capabilities})
      lspconfig.clangd.setup({capabilities = capabilities})
      lspconfig.cssls.setup({capabilities = capabilities})
      lspconfig.cssmodules_ls.setup({capabilities = capabilities})
      lspconfig.unocss.setup({capabilities = capabilities})
      lspconfig.diagnosticls.setup({capabilities = capabilities})
      lspconfig.dockerls.setup({capabilities = capabilities})
      lspconfig.docker_compose_language_service.setup({capabilities = capabilities})
      lspconfig.eslint.setup({capabilities = capabilities})
      lspconfig.golangci_lint_ls.setup({capabilities = capabilities})
      lspconfig.gopls.setup({capabilities = capabilities})
      lspconfig.grammarly.setup({capabilities = capabilities})
      lspconfig.graphql.setup({capabilities = capabilities})
      lspconfig.html.setup({capabilities = capabilities})
      lspconfig.helm_ls.setup({capabilities = capabilities})
      lspconfig.jsonls.setup({capabilities = capabilities})
      lspconfig.biome.setup({capabilities = capabilities})
      lspconfig.tsserver.setup({capabilities = capabilities})
      lspconfig.sqlls.setup({capabilities = capabilities})
      lspconfig.tailwindcss.setup({capabilities = capabilities})
      lspconfig.templ.setup({capabilities = capabilities})
      lspconfig.terraformls.setup({capabilities = capabilities})
      lspconfig.tflint.setup({capabilities = capabilities})
      lspconfig.yamlls.setup({capabilities = capabilities})
      lspconfig.terraformls.setup({capabilities = capabilities})
      lspconfig.terraformls.setup({capabilities = capabilities})
      lspconfig.terraformls.setup({capabilities = capabilities})

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  }
}
