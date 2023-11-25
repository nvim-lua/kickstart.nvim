return {
  -- LSP Configuration & Plugin
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {}
    },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', function()
        vim.lsp.buf.code_action(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      --   vim.lsp.buf.format()
      -- end, { desc = 'Format current buffer with LSP and lint' })

      -- Enable auto-formatting on save
      vim.api.nvim_command([[
        augroup AutoFormatOnSave
          autocmd!
          autocmd BufWritePre * :Format
        augroup END
      ]])
    end

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Servers configuration
    local servers = {
      clangd = {},
      gopls = {
        settings = {
          plugins = {
            revive = {},
          },
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analysis = {
              unusedParams = true,
            },
          },
        },
      },
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              black = {
                blackArgs = {
                  "--line-length", "79",
                  "--exclude", "venv",
                  "--exclude", "env",
                  "--exclude", ".git",
                  "--exclude", ".hg",
                },
                lineLength = 79,
              },
              flake8 = {},
              isort = {
                profile = "black",
              },
              mypy = {
                args = {},
                command = "mypy",
                diagnostics = true,
                enabled = true,
              },
              pycodestyle = {
                ignore = { "W391" },
                maxLineLength = 79,
              },
            },
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "strict",
                useLibraryCodeForTypes = true,
              },
              pythonPath = "/usr/local/bin/python3",
            },
          },
        },
      },
      -- rust_analyzer = {},
      -- tsserver = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    -- Setup Mason configuration
    local mason = require('mason')
    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }

    -- Ensure the servers above are installed
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- Add Mason handlers
    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end
    }

    -- Load nvim-cmp after Mason to allow Mason to configure it first
    require('cmp')
  end
}
