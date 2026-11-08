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
      nix = { 'nixpkgs_fmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      clang_format = {
        prepend_args = { '-style={IndentWidth: 4}' },
      },
      prettier = {
        append_args = { '--tab-width', '4' },
      },
    },
  },
}
