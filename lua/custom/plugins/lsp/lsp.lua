-- ~/dlond/nvim/lua/custom/plugins/lsp.lua
-- LSP configuration, assuming LSP servers are installed via Nix/Home Manager

return {
  {
    'neovim/nvim-lspconfig',
    -- only load when editing these filetypes (optional)
    ft = { 'python', 'lua', 'nix', 'rust', 'go', 'c', 'cpp' },
    opts = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=never',
            '--query-driver=' .. vim.fn.exepath('clang++'),
            '--resource-dir=' .. vim.fn.systemlist({ 'clang++', '--print-resource-dir' })[1],
          },
          filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
          root_dir = require('lspconfig.util').root_pattern('.git'),
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
        nixd = {},
        ruff = {},
        texlab = {},
        cmake = {
          cmd = { 'cmake-language-server' },
          filetypes = { 'cmake' },
          root_dir = require('lspconfig.util').root_pattern('CMakeLists.txt', '.git'),
        },
      }

      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        lspconfig[name].setup(config)
      end
    end,
  },
}
