return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    {
      'j-hui/fidget.nvim',
      tag = 'v1.4.0',
      opts = {
        progress = {
          display = { done_icon = '✓' },
        },
        notification = {
          window = { winblend = 0 },
        },
      },
    },
    {
      'glepnir/lspsaga.nvim',
      event = 'LspAttach',
      config = function()
        require('lspsaga').setup {
          ui = { border = 'rounded', title = true },
          hover = { max_width = 0.6 },
          rename = { in_select = false },
        }
      end,
    },
  },

  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local telescope_ok, telescope = pcall(require, 'telescope.builtin')
        if not telescope_ok then return end

        map('gd', telescope.lsp_definitions, 'Go to Definition')
        map('gr', telescope.lsp_references, 'Go to References')
        map('gI', telescope.lsp_implementations, 'Go to Implementation')
        map('<leader>D', telescope.lsp_type_definitions, 'Type Definition')
        map('<leader>ds', telescope.lsp_document_symbols, 'Document Symbols')
        map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('gD', vim.lsp.buf.declaration, 'Go to Declaration')

        map('<S-K>', function()
          local lspsaga_hover_ok, lspsaga_hover = pcall(require, 'lspsaga.hover')
          if lspsaga_hover_ok then
            lspsaga_hover:render_hover_doc()
          else
            vim.lsp.buf.hover()
          end
        end, 'Show Hover')

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

    -- LSP Server Configurations
    local servers = {
      gopls = {
        settings = {
          gopls = {
            experimentalPostfixCompletions = true,
            gofumpt = true,
            staticcheck = true,
            analyses = { unusedparams = true },
            directoryFilters = { '-node_modules' },
            templ = {
              format = true,
              lint = true,
            },
          },
        },
        filetypes = { 'go', 'templ' },
      },
      -- tsserver = { settings = { completions = { completeFunctionCalls = true }, }, filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript' }, root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', '.git'), },
      eslint = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } }, -- Removed 'templ' from here
      templ = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/templ", "lsp" },
        filetypes = { "templ" },
        root_dir = require("lspconfig").util.root_pattern("go.mod", ".git"),
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            completion = { callSnippet = 'Replace' },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      dockerls = {},
      docker_compose_language_service = {},
      rust_analyzer = {
        ['rust-analyzer'] = {
          cargo = { features = 'all' },
          checkOnSave = true,
          check = { command = 'clippy' },
        },
      },
      tailwindcss = {},
      jsonls = {},
      yamlls = {},
      bashls = {},
      graphql = {},
      cssls = {},
    }

    -- Enable LSP Features
    require('mason').setup()
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { 'templ', 'typescript-language-server' })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities(),
            server.capabilities or {}
          )
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- Auto-format and organize imports on save for Go
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        vim.lsp.buf.format({ async = false }) -- Format
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        }) -- Organize imports
      end,
    })
  end,
}
