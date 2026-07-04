---@diagnostic disable: undefined-global
local go_flags = 'integration' -- add the tags here, instead of searching it below

return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 
      'williamboman/mason.nvim', 
      cmd = { "Mason", "MasonInstall", "MasonUpdate" }, 
      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
            },
            border = "rounded",
            width = 0.8,
            height = 0.9,
          },
          log_level = vim.log.levels.INFO,
          max_concurrent_installers = 4,
        })
      end
    },
    { 
      'williamboman/mason-lspconfig.nvim', 
      dependencies = { 'williamboman/mason.nvim' },
      config = function()
        require("mason-lspconfig").setup({
          automatic_installation = true
        })
      end
    },
    -- 'folke/neodev.nvim',  -- Adds support for Neovim Lua API -- No longer needed with lazydev
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      event = 'VeryLazy',
      config = function()
        require('mason-tool-installer').setup {
          ensure_installed = {
            'lua-language-server',
            'stylua', -- Lua formatter
            'marksman',
            -- Go tools
            'gopls', -- Go LSP
            'gofumpt', -- Stricter Go formatter
            'goimports', -- Go import manager
            'golangci-lint', -- Go linter
            'delve', -- Go debugger
            -- Zig tools
            'zls', -- Zig LSP
            -- C tools
            'clangd', -- C/C++ LSP
            'clang-format', -- C/C++ formatter
            'codelldb', -- Native code debugger
            -- Python tools
            'pyright', -- Python LSP
            'black', -- Python formatter
            'ruff', -- Python linter
            'debugpy', -- Python debugger
            -- SQL tools
            'sqls', -- Advanced SQL LSP
            -- Shell tools
            'bash-language-server', -- Bash LSP
            'shellcheck', -- Shell linter
            'shfmt', -- Shell formatter
          },
          auto_update = true,
          run_on_start = true,
        }
      end,
    },

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',

    -- Add nvim-navic for breadcrumbs
    { 'SmiteshP/nvim-navic', config = function()
      require('nvim-navic').setup {
        highlight = true,
        separator = ' > ',
        depth_limit = 5,
      }
    end },
  },
  config = function()
    require('plugins.lsp.setup').setup()
  end,
}
