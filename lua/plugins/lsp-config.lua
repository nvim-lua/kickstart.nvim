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
        ensure_installed = { "lua_ls","angularls","ansiblels","clangd","cssls","cssmodules_ls","unocss","diagnosticls","dockerls","docker_compose_language_service","eslint","golangci_lint_ls","gopls","grammarly","graphql","html","helm_ls","jsonls","biome","tsserver","sqlls","tailwindcss","templ","terraformls","tflint","yamlls"},
      }
    end
  },
  {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup({})
    lspconfig.angularls.setup({})
    lspconfig.ansiblels.setup({})
    lspconfig.clangd.setup({})
    lspconfig.cssls.setup({})
    lspconfig.cssmodules_ls.setup({})
    lspconfig.unocss.setup({})
    lspconfig.diagnosticls.setup({})
    lspconfig.dockerls.setup({})
    lspconfig.docker_compose_language_service.setup({})
    lspconfig.eslint.setup({})
    lspconfig.golangci_lint_ls.setup({})
    lspconfig.gopls.setup({})
    lspconfig.grammarly.setup({})
    lspconfig.graphql.setup({})
    lspconfig.html.setup({})
    lspconfig.helm_ls.setup({})
    lspconfig.jsonls.setup({})
    lspconfig.biome.setup({})
    lspconfig.tsserver.setup({})
    lspconfig.sqlls.setup({})
    lspconfig.tailwindcss.setup({})
    lspconfig.templ.setup({})
    lspconfig.terraformls.setup({})
    lspconfig.tflint.setup({})
    lspconfig.yamlls.setup({})
    lspconfig.terraformls.setup({})
    lspconfig.terraformls.setup({})
    lspconfig.terraformls.setup({})

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
