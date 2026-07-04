---@diagnostic disable: undefined-global
-- LSP servers configuration

-- Go flags for build tags
local go_flags = 'integration'
local gopls_build_flags = go_flags ~= '' and { '-tags=' .. go_flags } or {}

return {
  -- Python
  pyright = {},

  -- Bash/Shell
  bashls = {
    filetypes = { 'sh', 'bash', 'zsh' },
    settings = {
      bashIde = {
        globPattern = '*@(.sh|.inc|.bash|.command)',
        shellcheckPath = 'shellcheck',
      },
    },
  },
  -- Go
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = false,
        gofumpt = false,
        hints = {
          assignVariableTypes = false,
          compositeLiteralFields = false,
          compositeLiteralTypes = false,
          constantValues = false,
          functionTypeParameters = false,
          parameterNames = false,
          rangeVariableTypes = false,
        },
        vulncheck = 'Off',
        completionBudget = '100ms',
        symbolMatcher = 'FastFuzzy',
        symbolStyle = 'Dynamic',
        diagnosticsDelay = '500ms',
        buildFlags = gopls_build_flags,
      },
    },
  },
  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.stdpath 'config' .. '/lua'] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
  },
  -- C/C++
  clangd = {
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--header-insertion=iwyu',
      '--completion-style=detailed',
      '--function-arg-placeholders',
      '--fallback-style=llvm',
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    on_attach = function(client, bufnr)
      -- Set the correct standard based on filetype
      local filetype = vim.bo[bufnr].filetype
      if filetype == 'c' then
        client.config.init_options.fallbackFlags = { '-std=c23' }
      elseif filetype == 'cpp' then
        client.config.init_options.fallbackFlags = { '-std=c++23' }
      end

      -- Call the default on_attach to setup keymaps and navic
      require('plugins.lsp.setup').default_on_attach(client, bufnr)
    end,
    settings = {
      clangd = {
        InlayHints = {
          Designators = true,
          Enabled = true,
          ParameterNames = true,
          DeducedTypes = true,
        },
      },
    },
  },

  -- Zig
  zls = {
    settings = {
      zls = {
        -- Enable semantic highlighting
        enable_semantic_tokens = true,
        -- Enable inlay hints for better code understanding
        enable_inlay_hints = true,
        -- Enable snippets
        enable_snippets = true,
        -- Enable auto-fixing
        enable_autofix = true,
        -- Warn about style issues
        warn_style = true,
        -- Highlight global variables
        highlight_global_var_declarations = true,
        -- Enable build-on-save for faster feedback
        enable_build_on_save = true,
        -- Skip std library references for better performance
        skip_std_references = false,
        -- Prefer ast-check over zig fmt for faster response
        prefer_ast_check_as_child_process = true,
        -- Enable import embedfile argument completions
        enable_import_embedfile_argument_completions = true,
      },
    },
  },

  -- SQL
  sqls = {
    settings = {
      sqls = {
        connections = {},
        lowercaseKeywords = true,
      },
    },
  },
}
