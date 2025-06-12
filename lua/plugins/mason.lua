return {
  -- Mason: LSP/DAP/Linter/Formatter installer
  {
    'mason-org/mason.nvim',
    config = function()
      require('mason').setup()

      -- Add Mason bin directory to PATH
      local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin'
      local current_path = vim.env.PATH or ''
      if not string.find(current_path, mason_bin, 1, true) then
        vim.env.PATH = mason_bin .. ':' .. current_path
      end

      -- Auto-cleanup unused packages (add when deprecating packages)
      --
      vim.defer_fn(function()
        local registry = require 'mason-registry'
        local unused_packages = {
          'black',
          'mypy',
          'pyright',
          'nixpkgs-fmt',
          'python-lsp-server',
          'pyflakes',
          'pylint',
          'pep8',
        }

        for _, package_name in ipairs(unused_packages) do
          if registry.is_installed(package_name) then
            local package = registry.get_package(package_name)
            package:uninstall():once('closed', function()
              vim.notify('Removed unused package: ' .. package_name, vim.log.levels.INFO)
            end)
          end
        end
      end, 1000)
    end,
  },

  -- Mason tool installer for formatters/linters
  -- Note: mason-lspconfig.nvim is not used for LSP beyond installs, we use vim.lsp fot that
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    config = function()
      -- Function to translate LSP server names to Mason package names using mason-lspconfig
      local function translate_lsp_names(lsp_servers)
        local mason_packages = {}
        local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

        if ok then
          for _, server in ipairs(lsp_servers) do
            local success, package_name = pcall(mason_lspconfig.get_mason_package, server)
            if success and package_name then
              table.insert(mason_packages, package_name.name)
            else
              -- Fallback to original name if no mapping found
              table.insert(mason_packages, server)
            end
          end
        else
          -- If mason-lspconfig not available, use original names
          mason_packages = lsp_servers
        end

        return mason_packages
      end

      -- LSP servers to install (using mason-lspconfig names)
      local lsp_servers = {
        'clangd',
        'basedpyright',
        'bashls', -- bash-language-server
        'dockerls', -- dockerfile-language-server
        -- 'gopls', -- go
        'jedi_language_server',
        'lua_ls', -- lua-language-server
        'marksman',
        'rust_analyzer',
        'taplo',
        'ts_ls', -- typescript-language-server
        'yamlls', -- yaml-language-server
      }

      -- Other tools
      local other_tools = {
        -- Formatters
        'alejandra', -- nix
        'ast-grep',
        'clang-format',
        'cmakelang',
        'isort', -- python
        'prettier',
        'ruff', -- python
        'shfmt',
        'stylua',

        -- Linters
        'ast-grep',
        'cmakelint',
        'cpplint',
        'golangci-lint',
        'ruff', -- python
        'yamllint',
        'golangci-lint',

        -- Debuggers
        'debugpy',

        -- Additional tools
        'tree-sitter-cli',
      }

      -- Combine translated LSP servers with other tools
      local all_tools = {}
      vim.list_extend(all_tools, translate_lsp_names(lsp_servers))
      vim.list_extend(all_tools, other_tools)

      require('mason-tool-installer').setup {
        ensure_installed = all_tools,
        auto_update = false,
        run_on_start = true,
      }
    end,
  },
}
