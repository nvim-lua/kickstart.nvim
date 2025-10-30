-- ========================================================================
-- PYTHON PROFILE - Language-specific plugins and LSP configuration
-- ========================================================================
--
-- This file contains all Python-specific plugins and configurations.
-- These plugins will ONLY load when you open a .py file, keeping your
-- startup time fast and avoiding conflicts with other languages.
--
-- Key features to configure here:
--   - Python LSP (pyright or pylsp)
--   - Python formatters (black, ruff, isort, etc.)
--   - Python linters and type checkers
--   - Debugger integration (debugpy)
--   - Testing tools (pytest)
--   - Virtual environment detection
--   - Python-specific keymaps
--
-- Usage: Just open a .py file and these plugins will automatically load!
-- ========================================================================

return {
  -- ========================================================================
  -- PYTHON LSP - Language Server Protocol for Python
  -- ========================================================================
  -- Provides intelligent code completion, go-to-definition, type checking,
  -- and more for Python files using pyright (fast, feature-rich LSP)
  -- ========================================================================
  {
    'neovim/nvim-lspconfig',
    ft = 'python', -- Only load when opening Python files
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim', -- For installing pyright
    },
    config = function()
      -- Get shared LSP capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Setup pyright LSP server
      require('lspconfig').pyright.setup {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              -- Type checking mode: "off", "basic", or "strict"
              typeCheckingMode = 'basic',
              -- Auto-import completions
              autoImportCompletions = true,
              -- Automatically search for stubs
              autoSearchPaths = true,
              -- Use library code for types
              useLibraryCodeForTypes = true,
              -- Diagnostic mode: "openFilesOnly" or "workspace"
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
      }

      -- Install Python tools via Mason
      require('mason-tool-installer').setup {
        ensure_installed = {
          'pyright', -- LSP server for type checking and completions
          'ruff', -- Fast formatter, linter, and import organizer (replaces black, isort, flake8)
        },
      }
    end,
  },

  -- ========================================================================
  -- PYTHON FORMATTERS - Auto-format Python code
  -- ========================================================================
  -- Uses Ruff for fast formatting and import organization
  -- Ruff provides Black-compatible formatting + import sorting in one tool
  -- ========================================================================
  {
    'stevearc/conform.nvim',
    ft = 'python',
    opts = function(_, opts)
      -- Extend the existing formatters_by_ft table
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.python = {
        -- Ruff handles both formatting and import sorting (fast & modern)
        'ruff_organize_imports', -- First: organize imports
        'ruff_format', -- Then: format code (Black-compatible)
      }
      return opts
    end,
  },

  -- ========================================================================
  -- PYTHON-SPECIFIC KEYMAPS AND CONFIGURATION
  -- ========================================================================
  -- Additional Python-specific settings and keymaps
  -- ========================================================================
  {
    'nvim-treesitter/nvim-treesitter',
    ft = 'python',
    opts = function(_, opts)
      -- Ensure Python parser is installed
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'python' })
      return opts
    end,
  },
}
