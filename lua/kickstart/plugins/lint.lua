return {
  { -- Linting
    'mfussenegger/nvim-lint',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
     'rshkarin/mason-nvim-lint',
    },
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile', 'InsertLeave' },
    config = function()
      local lint = require 'lint'
      local ensure_installed = {
          'actionlint',
          'ansible-lint',
          'cmakelint',
          'cpplint',
          'eslint_d',
          'golangci-lint',
          'hadolint',
          'jsonlint',
          'ktlint',
          'luacheck',
          'markdownlint',
          -- 'markdownlint-cli2',
          -- 'npm-groovy-lint',
          'pylint',
          -- 'semgrep',
          'shellcheck',
          'shellharden',
          'shfmt',
          'tflint',
          'trivy',
          'typos',
          'yamllint',
      }
      require('mason-nvim-lint').setup{
        automatic_installation = true,
        ensure_installed = ensure_installed,
        -- ignore_install = {},
      }
      lint.linters_by_ft = {
        ansible = { 'ansible_lint' },
        bash = { 'shellcheck', 'shellharden' },
        clojure = { nil },
        dockerfile = { 'hadolint' },
        -- helm = { 'helm_lint'}, -- helm_lint is currently available.
        inko = { nil },
        janet = { nil },
        -- java = { 'semgrep' }, -- Need to find an alternative here.
        javascript = { 'eslint_d' },
        json = { 'jsonlint' },
        kotlin = { 'ktlint' },
        -- gitcommit = { 'gitlint', 'gitleaks' }, -- Handled better by `pre-commit`.
        go = { 'golangcilint' },
        -- graphql = { 'prettierd' },
        -- groovy = { 'npm-groovy-lint' },
        latex = { 'vale' },
        lua = { 'luacheck' },
        markdown = { 'markdownlint' },
        postgres = { 'sqlfluff' },
        python = { 'pylint', 'ruff' },
        -- rust = { 'bacon' }, -- bacon is present in the registry, but does not function.
        sh = { 'shellcheck', 'shellharden' },
        sql = { 'sqlfluff' },
        terraform = { 'tflint' },
        tofu = { 'tflint' },
        -- toml = { '' },
        text = { 'vale' },
        typescript = { 'eslint_d' },
        yaml = { 'yamllint', 'actionlint' },
        zsh = { 'shellcheck', 'shellharden' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
              lint.try_lint()
          end
        end,
      })
    end,
  }
}
