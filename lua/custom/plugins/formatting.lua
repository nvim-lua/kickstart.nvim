-- Formatter configuration

return {
  -- ========================================
  -- Formatter Configuration (conform.nvim)
  -- ========================================
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre', -- Format on save
    -- cmd = { 'ConformInfo' }, -- Optional: If you want the command available
    -- keys = { ... } -- Optional: Define keys if needed
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        python = { 'isort', 'black' },
        nix = { 'nixpkgs-fmt' }, -- Add nix formatter
        -- Add other filetypes and formatters, e.g.:
        -- javascript = { "prettier" },
        -- typescript = { "prettier" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        -- json = { "prettier" },
        -- yaml = { "prettier" },
        -- markdown = { "prettier" },
        -- bash = { "shfmt" },
      },
      -- Configure format_on_save behavior
      format_on_save = {
        -- I recommend these options, but adjust to your liking
        timeout_ms = 500, -- Stop formatting if it takes too long
        lsp_fallback = true, -- Fallback to LSP formatting if conform fails
      },
    },
  },
}
