-- LSP Server Configurations
local M = {}

local util = require 'lspconfig.util'

-- Query driver for clangd to find compilers in various locations
local function get_clangd_query_driver()
  return table.concat({
    '/nix/store/*/bin/clang*',
    '/opt/homebrew/opt/llvm/bin/clang*',
    '/usr/bin/clang*',
  }, ';')
end

-- Get clang resource directory
local function get_clang_resource_dir()
  local ok, result = pcall(vim.fn.systemlist, { 'clang++', '--print-resource-dir' })
  if ok and result and result[1] then
    return result[1]
  else
    return '/usr/lib/clang/19/include' -- fallback
  end
end

function M.get_servers()
  return {
    -- C/C++ Language Server
    clangd = {
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=never',
        '--query-driver=' .. get_clangd_query_driver(),
        -- Remove hardcoded build dir - clangd will search for compile_commands.json
        -- in the current directory and all parent directories by default
        '--resource-dir=' .. get_clang_resource_dir(),
        -- Help clangd find system headers
        '--fallback-style=llvm',
      },
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      -- First check for compile_commands.json in build/, then at root, then other markers
      root_dir = function(fname)
        -- Look for compile_commands.json in build/ first
        local build_dir = util.root_pattern('build/compile_commands.json')(fname)
        if build_dir then
          return build_dir
        end
        -- Then look for it at project root or other markers
        return util.root_pattern('compile_commands.json', 'compile_flags.txt', '.clangd', 'CMakeLists.txt', '.git')(fname)
      end,
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