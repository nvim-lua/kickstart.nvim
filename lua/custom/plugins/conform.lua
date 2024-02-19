return {
  'stevearc/conform.nvim',
  dependencies = {
    'williamboman/mason.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    local registry = require 'mason-registry'
    registry.refresh(function()
      for _, tbl in pairs(opts.formatters_by_ft) do
        for _, pkg_name in ipairs(tbl) do
          -- TODO the name formatters_by_ft needed may be different from the name mason needed
          if pkg_name == 'ruff_format' then
            pkg_name = 'ruff'
          end
          local pkg = registry.get_package(pkg_name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end
    end)
    require('conform').setup(opts)
  end,
}
