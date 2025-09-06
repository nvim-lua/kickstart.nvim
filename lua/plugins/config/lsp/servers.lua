-- LSP Server Configurations
local M = {}

local util = require 'lspconfig.util'

-- Get clang-wrapper resource-root for Nix environments
local function get_clang_resource_dir()
  -- Try to find clang-wrapper's resource-root
  local handle = io.popen 'ls -d /nix/store/*clang-wrapper*/resource-root 2>/dev/null | head -1'
  if handle then
    local resource_root = handle:read '*l'
    handle:close()
    if resource_root and resource_root ~= '' then
      return resource_root
    end
  end
  return nil -- Let clangd use its default
end

function M.get_servers()
  -- Build clangd command
  local clangd_cmd = {
    'clangd',
    '--query-driver=/nix/store/*/bin/clang*',
    '--background-index',
    '--clang-tidy',
    '--enable-config',
    '--fallback-style=llvm',
    '--function-arg-placeholders',
    '--header-insertion-decorators',
    '--header-insertion=iwyu',
  }

  -- Add resource-dir if in Nix environment
  local resource_dir = get_clang_resource_dir()
  if resource_dir then
    table.insert(clangd_cmd, '--resource-dir=' .. resource_dir)
  end

  return {
    -- C/C++ Language Server
    clangd = {
      cmd = clangd_cmd,
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
