-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local Languages = {
  ['python'] = {
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'workspace',
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,
          },
        },
      },
      disableLanguageServices = false,
    },
    basedpyright = {
      settings = {
        basedpyright = {
          analysis = {
            autoSearchPaths = true,
            typeCheckingMode = 'basic',
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
          },
        },
      },
    },
  },
  ['go'] = {
    gopls = {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
          },
          gofumpt = true,
        },
      },
    },
  },
  ['rust'] = {
    rust_analyzer = {
      alias = 'rust-analyzer',
    },
  },
  ['markdown'] = {
    markdown_oxide = {
      alias = 'markdown-oxide',
    },
  },
  ['nix'] = {
    nixd = {
      settings = {
        nixd = {
          nixpkgs = {
            expr = 'import <nixpkgs> { }',
          },
          formatting = {
            command = { 'nixfmt' },
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
            },
            home_manager = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
            },
          },
        },
      },
    },
    ['nil_ls'] = {
      alias = 'nil',
    },
  },
  ['bash'] = {
    bashls = {
      alias = 'bash-language-server',
    },
  },
  ['docker'] = {
    dockerls = {
      alias = 'docker-langserver',
    },
    docker_compose_language_service = {
      alias = 'docker-compose-langserver',
    },
  },
  ['lua'] = {
    lua_ls = {
      -- cmd = {...},
      -- filetypes = { ...},
      -- capabilities = {},
      alias = 'lua-language-server',
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
    stylua = nil,
  },
}

return Languages
