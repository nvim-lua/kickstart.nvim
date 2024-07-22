return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {},
    },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      -- Key mappings for LSP features
      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', function()
        vim.lsp.buf.code_action(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, '[C]ode [A]ction')

      nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('gv', ':vsplit<CR>:lua vim.lsp.buf.declaration()<CR>', '[G]oto [V]irtual Text')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if pcall(require, 'cmp_nvim_lsp') then
      capabilities = require('cmp_nvim_lsp').default_capabilities()
    end

    require('neodev').setup({
      library = {
        plugins = { 'nvim-dap-ui' },
        types = true,
      },
    })

    local servers = {
      clangd = {},
      gopls = {
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analysis = {
              unusedParams = true,
            },
          },
        },
      },
      htmx = {
        filetypes = { 'html' },
      },
      ruff_lsp = {
        filetypes = { 'python' },
      },
      pyright = {
        filetypes = { 'python' },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = false,
              diagnosticMode = 'workspace',
              useLibraryCodeForTypes = true,
              typeCheckingMode = 'off',
            },
          },
        },
      },
      rust_analyzer = {
        cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
      },
      lua_ls = {
        filetypes = { 'lua' },
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
      ocamllsp = {
        manual_install = true,
        filetypes = { 'ocaml', 'ocaml.interface', 'ocaml.cram', 'ocaml.menhir' },
        settings = {
          codelens = { enabled = true },
          inlayHints = { enable = true },
        },
      },
      yamlls = {
        filetypes = { 'yaml' },
        settings = {
          yaml = {
            schemas = {
              ['https://json.schemasstore.org/github-workflow.json'] = '/.github/workflows/*.{yml,yaml}',
            },
          },
        },
      },
      taplo = {
        filetypes = { 'toml' },
      },
      dockerls = {
        filetypes = { 'Dockerfile' },
      },
    }

    local ensure_installed = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == 'table' then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({
      ensure_installed = ensure_installed,
    })

    for name, config in pairs(servers) do
      if config then
        require('lspconfig')[name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = config.settings,
          filetypes = config.filetypes,
          cmd = config.cmd,
        })
      end
    end

    require('cmp')

    local sign = function(opts)
      vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = '',
      })
    end

    vim.diagnostic.config({
      underline = true,
      severity_sort = true,
      signs = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 2,
      },
      float = {
        source = 'if_many',
        border = 'rounded',
      },
    })

    sign({ name = 'DiagnosticSignError', text = '✘' })
    sign({ name = 'DiagnosticSignWarn', text = '▲' })
    sign({ name = 'DiagnosticSignHint', text = '⚑' })
    sign({ name = 'DiagnosticSignInfo', text = '»' })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
  end,
}

