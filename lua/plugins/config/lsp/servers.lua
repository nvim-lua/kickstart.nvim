-- LSP Server Configurations
local M = {}

local util = require 'lspconfig.util'

function M.get_servers()
  return {
    -- C/C++ Language Server
    -- The clangd from dev-shells is already wrapped with --query-driver and --enable-config
    clangd = {
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--fallback-style=llvm',
        '--function-arg-placeholders',
        '--header-insertion-decorators',
        '--header-insertion=iwyu',
      },
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      -- Look for project markers - clangd will find compile_commands.json itself
      root_dir = util.root_pattern(
        -- First check for any compile_commands.json anywhere
        'compile_commands.json',
        -- Then check common build directories
        'build/compile_commands.json',
        'Debug/compile_commands.json',
        'Release/compile_commands.json',
        -- Project markers
        '.clangd',
        'compile_flags.txt',
        'CMakeLists.txt',
        'Makefile',
        '.git'
      ),
      single_file_support = true,
    },

    -- Python Language Server
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'basic',
          },
        },
      },
      positionEncoding = 'utf-8',
    },

    -- Python Linter/Formatter
    ruff = {},

    -- Nix Language Server
    nixd = {},

    -- LaTeX Language Server
    texlab = {},

    -- CMake Language Server
    cmake = {
      cmd = { 'cmake-language-server' },
      filetypes = { 'cmake' },
      root_dir = util.root_pattern('CMakeLists.txt', '.git'),
    },

    -- Add more servers here as needed
    -- Example:
    -- rust_analyzer = {
    --   settings = {
    --     ['rust-analyzer'] = {
    --       checkOnSave = {
    --         command = 'clippy',
    --       },
    --     },
    --   },
    -- },
  }
end

return M

