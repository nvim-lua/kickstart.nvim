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
  -- MASON TOOL INSTALLER - Install Python tools on-demand
  -- ========================================================================
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    ft = 'python',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      -- Wait for Mason registry to be ready
      local function install_tools()
        local registry_ok, registry = pcall(require, 'mason-registry')
        if not registry_ok then
          vim.notify('Mason registry not ready, retrying...', vim.log.levels.WARN)
          vim.defer_fn(install_tools, 100)
          return
        end

        -- Refresh registry and install tools
        registry.refresh(function()
          local tools = { 'pyright', 'ruff' }
          for _, tool in ipairs(tools) do
            local ok, package = pcall(registry.get_package, tool)
            if ok and not package:is_installed() then
              vim.notify('Installing ' .. tool .. '...', vim.log.levels.INFO)
              package:install()
            end
          end
        end)
      end

      -- Start installation after a short delay
      vim.defer_fn(install_tools, 200)
    end,
  },

  -- ========================================================================
  -- PYTHON LSP - Language Server Protocol for Python
  -- ========================================================================
  -- Note: Pyright LSP setup is in init.lua (after lazy.setup) because
  -- nvim-lspconfig is already loaded there, and we can't re-trigger its
  -- config function with ft='python'. The autocmd in init.lua will start
  -- pyright when you open a .py file.
  -- ========================================================================


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
