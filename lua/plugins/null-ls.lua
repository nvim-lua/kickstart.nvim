return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local null_ls_utils = require 'null-ls.utils'

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
      root_dir = null_ls_utils.root_pattern('.null-ls-root', 'Makefile', '.git'),
      timeout = 10000,  -- Reduced timeout
      debounce = 250,   -- Add debounce to prevent excessive updates
      update_in_insert = false,  -- Only update diagnostics when leaving insert mode
      sources = {
        -- Go formatting and linting
        formatting.gofumpt.with({
          extra_args = { "-extra" },  -- More aggressive formatting
        }),
        formatting.goimports.with({
          args = { "-local", "", "-w", "$FILENAME" },  -- Optimize imports
        }),
        diagnostics.golangci_lint.with({
          diagnostics_format = '#{m}',
          extra_args = {
            '--fast',
            '--max-issues-per-linter', '30',
            '--max-same-issues', '4',
            '--max-same-issues-per-linter', '0',  -- Disable duplicate issue reporting per linter
            '--fix=false',  -- Don't try to fix issues
            '--tests=false',  -- Don't analyze tests for faster results
            '--print-issued-lines=false',  -- Don't print the lines that triggered issues
            '--timeout=10s',  -- Timeout after 10 seconds
            '--out-format=json',  -- Use JSON format for faster parsing
          },
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE,  -- Only run on save
          timeout = 10000,  -- 10 second timeout
        }),

        -- Web formatting
        formatting.prettier.with {
          filetypes = { 'css', 'scss', 'html', 'markdown', 'yaml', 'yml' },
          extra_args = {
            '--bracket-same-line',
            '--trailing-comma', 'all',
            '--tab-width', '2',
            '--semi',
            '--single-quote',
          },
        },

        -- Shell formatting
        formatting.shfmt.with {
          extra_args = { '-i', '2', '-ci', '-bn' },
        },

        -- SQL formatting
        formatting.sqlfluff.with {
          extra_args = { '--dialect', 'tsql' },
        },
      },
    }
  end,
}
