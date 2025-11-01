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
  -- Pyright LSP is started via autocmd when opening .py files
  -- This approach works because we set it up after LSP infrastructure loads
  -- ========================================================================
  {
    'neovim/nvim-lspconfig',
    ft = 'python',
    config = function()
      -- Python LSP - starts when opening .py files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        once = false,
        callback = function(args)
          -- Check if pyright is already attached
          local clients = vim.lsp.get_clients { bufnr = args.buf, name = 'pyright' }
          if #clients > 0 then
            return
          end

          -- Get capabilities from blink.cmp
          local capabilities = require('blink.cmp').get_lsp_capabilities()

          local root_dir = vim.fs.root(args.buf, {
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            'pyrightconfig.json',
            '.git',
          })

          -- Find Python interpreter (prioritize virtual environments)
          local function find_python()
            if not root_dir then
              return nil
            end

            -- Check common venv locations relative to project root
            local venv_paths = {
              root_dir .. '/.venv/bin/python',
              root_dir .. '/venv/bin/python',
              root_dir .. '/.env/bin/python',
              root_dir .. '/env/bin/python',
            }

            for _, path in ipairs(venv_paths) do
              if vim.fn.executable(path) == 1 then
                return path
              end
            end

            return nil
          end

          local python_path = find_python()

          vim.lsp.start {
            name = 'pyright',
            cmd = { vim.fn.stdpath 'data' .. '/mason/bin/pyright-langserver', '--stdio' },
            root_dir = root_dir or vim.fn.getcwd(),
            capabilities = capabilities,
            settings = {
              python = {
                pythonPath = python_path,
                analysis = {
                  typeCheckingMode = 'basic',
                  autoImportCompletions = true,
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = 'openFilesOnly',
                },
              },
            },
          }
        end,
      })
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
