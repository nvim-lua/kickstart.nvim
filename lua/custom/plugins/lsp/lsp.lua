-- ~/dlond/nvim/lua/custom/plugins/lsp.lua
-- LSP configuration, assuming LSP servers are installed via Nix/Home Manager

return {
  {
    'neovim/nvim-lspconfig',
    -- only load when editing these filetypes (optional)
    ft = { 'python', 'lua', 'nix', 'rust', 'go' },
    opts = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
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
        clangd = (function()
          local cmd = { 'clangd', '--background-index' }
          return {
            cmd = cmd,
            filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
            root_dir = lspconfig.util.root_pattern('compile_commands.json', '.git'),
            single_file_support = true,
            -- on_attach = function(client, bufnr)
            --   local util = require(custom.plugins.lsp.clangd_helper)
            --   util.notify_compile_commands(bufnr)
            --   util.start_compile_commands_watcher(client, bufnr)
            -- end,
          }
        end)(),
      }

      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        lspconfig[name].setup(config)
      end
    end,
  },
}
