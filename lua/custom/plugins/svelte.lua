-- ========================================================================
-- SVELTE PROFILE - Language-specific plugins and LSP configuration
-- ========================================================================
--
-- This file contains all Svelte-specific plugins and configurations.
-- These plugins will ONLY load when you open a .svelte file, keeping your
-- startup time fast and avoiding conflicts with other languages.
--
-- Key features to configure here:
--   - Svelte LSP (svelte-language-server)
--   - TypeScript/JavaScript support for Svelte components
--   - Tailwind CSS integration (if using Tailwind)
--   - Prettier formatting for Svelte files
--   - Emmet support for Svelte
--   - Svelte-specific keymaps
--
-- Note: You may also want to configure support for related web files:
--   - JavaScript/TypeScript (.js, .ts)
--   - HTML/CSS (.html, .css)
--
-- Usage: Just open a .svelte file and these plugins will automatically load!
-- ========================================================================

return {
  -- ========================================================================
  -- SVELTE LSP - Language Server Protocol for Svelte
  -- ========================================================================
  -- Provides intelligent code completion, diagnostics, and more for Svelte
  -- components, including support for TypeScript, CSS, and HTML within .svelte files
  -- ========================================================================
  {
    'neovim/nvim-lspconfig',
    ft = { 'svelte', 'typescript', 'javascript' }, -- Load for web files
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      -- Get shared LSP capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Setup Svelte LSP server using new vim.lsp.config API (Neovim 0.11+)
      local svelte_config = require('lspconfig.configs').svelte
      if svelte_config then
        vim.lsp.config('svelte', {
          cmd = svelte_config.default_config.cmd,
          filetypes = svelte_config.default_config.filetypes,
          root_markers = svelte_config.default_config.root_dir,
          capabilities = capabilities,
          settings = {
            svelte = {
              plugin = {
                html = { completions = { enable = true, emmet = true } },
                svelte = { completions = { enable = true } },
                css = { completions = { enable = true } },
                typescript = { diagnostics = { enable = true } },
              },
            },
          },
        })
      end

      -- Setup TypeScript LSP for .ts/.js files in Svelte projects
      local tsserver_config = require('lspconfig.configs').ts_ls
      if tsserver_config then
        vim.lsp.config('ts_ls', {
          cmd = tsserver_config.default_config.cmd,
          filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
          },
          root_markers = tsserver_config.default_config.root_dir,
          capabilities = capabilities,
        })
      end

      -- Setup Tailwind CSS LSP if you're using Tailwind
      local tailwind_config = require('lspconfig.configs').tailwindcss
      if tailwind_config then
        vim.lsp.config('tailwindcss', {
          cmd = tailwind_config.default_config.cmd,
          filetypes = {
            'svelte',
            'html',
            'css',
            'scss',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
          },
          root_markers = tailwind_config.default_config.root_dir,
          capabilities = capabilities,
        })
      end

      -- Install web development tools via Mason
      require('mason-tool-installer').setup {
        ensure_installed = {
          'svelte-language-server', -- Svelte LSP
          'typescript-language-server', -- TypeScript/JavaScript LSP
          'tailwindcss-language-server', -- Tailwind CSS LSP (optional)
          'prettier', -- Code formatter for web files
          'eslint_d', -- Fast ESLint for linting JS/TS
        },
      }
    end,
  },

  -- ========================================================================
  -- WEB FORMATTERS - Prettier for Svelte/JS/TS/CSS
  -- ========================================================================
  -- Configures prettier to format Svelte and related web files
  -- ========================================================================
  {
    'stevearc/conform.nvim',
    ft = { 'svelte', 'typescript', 'javascript', 'css', 'html', 'json' },
    opts = function(_, opts)
      -- Extend the existing formatters_by_ft table
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.svelte = { 'prettier' }
      opts.formatters_by_ft.javascript = { 'prettier' }
      opts.formatters_by_ft.javascriptreact = { 'prettier' }
      opts.formatters_by_ft.typescript = { 'prettier' }
      opts.formatters_by_ft.typescriptreact = { 'prettier' }
      opts.formatters_by_ft.css = { 'prettier' }
      opts.formatters_by_ft.html = { 'prettier' }
      opts.formatters_by_ft.json = { 'prettier' }
      opts.formatters_by_ft.markdown = { 'prettier' }
      return opts
    end,
  },

  -- ========================================================================
  -- TREESITTER PARSERS - Syntax highlighting for web languages
  -- ========================================================================
  -- Ensures Treesitter parsers are installed for better syntax highlighting
  -- ========================================================================
  {
    'nvim-treesitter/nvim-treesitter',
    ft = { 'svelte', 'typescript', 'javascript', 'css', 'html' },
    opts = function(_, opts)
      -- Ensure web language parsers are installed
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'svelte',
        'typescript',
        'tsx',
        'javascript',
        'jsdoc',
        'css',
        'html',
        'json',
      })
      return opts
    end,
  },

  -- ========================================================================
  -- EMMET - HTML/CSS abbreviation expansion
  -- ========================================================================
  -- Provides Emmet abbreviation support for faster HTML/CSS writing
  -- Type abbreviations like `div.container>ul>li*3` and expand with <C-y>,
  -- ========================================================================
  {
    'mattn/emmet-vim',
    ft = { 'svelte', 'html', 'css', 'javascript', 'typescript' },
    init = function()
      -- Set Emmet leader key (default is <C-y>)
      vim.g.user_emmet_leader_key = '<C-e>'
      -- Enable only for specific file types
      vim.g.user_emmet_install_global = 0
      -- Enable Emmet for Svelte files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'html', 'css', 'svelte', 'javascript', 'typescript' },
        callback = function()
          vim.cmd 'EmmetInstall'
        end,
      })
    end,
  },
}
