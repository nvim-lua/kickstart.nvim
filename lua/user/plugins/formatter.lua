-- [[ Formatting: conform.nvim ]]
-- Only on demand with <leader>lf (buffer, or selection in visual mode).
-- Nothing formats on save.

require('conform').setup {
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
}

vim.keymap.set({ 'n', 'x' }, '<leader>lf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer or selection' })
