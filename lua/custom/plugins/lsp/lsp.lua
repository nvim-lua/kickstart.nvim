-- ~/dlond/nvim/lua/custom/plugins/lsp.lua
-- LSP configuration, assuming LSP servers are installed via Nix/Home Manager

return {
  {
    'neovim/nvim-lspconfig',
    -- only load when editing these filetypes (optional)
    ft = {
      'c',
      'cpp',
      'objc',
      'objcpp',
      'cuda',
      'cmake',
      --
      'go',
      'nix',
      'python',
      'rust',
      'tex',
    },
    opts = function()
      local lspconfig = require 'lspconfig'
      local capabilities = {}
      pcall(function()
        capabilities = require('blink.cmp').get_lsp_capabilities()
      end)
      local util = require 'lspconfig.util'

      local query_driver = table.concat({
        '/nix/store/*/bin/clang*',
        '/opt/homebrew/opt/llvm/bin/clang*',
        '/usr/bin/clang*',
      }, ';')

      local servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=never',
            '--query-driver=' .. query_driver,
            '--compile-commands-dir=build',
            '--resource-dir=' .. (function()
              local ok, result = pcall(vim.fn.systemlist, { 'clang++', '--print-resource-dir' })
              if ok and result and result[1] then
                return result[1]
              else
                return '/usr/lib/clang/19/include' -- fallback
              end
            end)(),
          },
          filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
          root_dir = util.root_pattern('CMakeLists.txt', '.git'),
          single_file_support = true,
        },

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
        ruff = {},

        nixd = {},

        texlab = {},

        cmake = {
          cmd = { 'cmake-language-server' },
          filetypes = { 'cmake' },
          root_dir = util.root_pattern('CMakeLists.txt', '.git'),
        },
      }

      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        lspconfig[name].setup(config)
      end
    end,
  },
}
