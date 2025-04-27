---@diagnostic disable: undefined-global
-- LSP servers configuration

-- Go flags for build tags
local go_flags = 'integration'
local gopls_build_flags = go_flags ~= '' and { '-tags=' .. go_flags } or {}

return {
  -- Python
  pyright = {},
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
  clangd = {},

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
