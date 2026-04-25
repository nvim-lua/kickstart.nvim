-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- NOTE: 
      -- See:
      -- - [Change format_on_save to a whitelist instead of a blacklist · nvim-lua/kickstart.nvim@ce353a9](https://github.com/nvim-lua/kickstart.nvim/commit/ce353a9b0e3c47d27784509217200818f522329e)
      -- - [please disable autoformat on save in default configuration · Issue #1819 · nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim/issues/1819)

      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      end
      return nil
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = Langs.fmt,
    -- Example
    -- rust = { 'rustfmt' },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },
    --
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
    formatters = Langs.fmt_cmd,
  },
}
