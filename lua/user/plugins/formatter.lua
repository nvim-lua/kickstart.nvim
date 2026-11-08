return { -- Formatting: only on demand with <leader>lf (no format on save)
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'LSP Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      -- Filetypes not listed here (lua, yaml) fall back to their language server
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      nix = { 'nixpkgs_fmt' },
      toml = { 'taplo' },
      python = { 'ruff_format' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      clang_format = {
        -- Use the project's .clang-format if there is one, otherwise 4-space indents
        prepend_args = function(_, ctx)
          if vim.fs.find({ '.clang-format', '_clang-format' }, { path = ctx.dirname, upward = true })[1] then
            return {}
          end
          return { '-style={IndentWidth: 4}' }
        end,
      },
      prettier = {
        append_args = { '--tab-width', '4' },
      },
    },
  },
}
