return {
  'mhartington/formatter.nvim',
  config = function()
    vim.cmd([[
                augroup FormatAutogroup
                    autocmd!
                    autocmd BufWritePost * :silent FormatWrite
                augroup END
            ]])
    local util = require "formatter.util"

    local prettierd = require("formatter.defaults.prettierd")

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require("formatter").setup {
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        javascript = prettierd,
        typescript = prettierd,
        typescriptreact = prettierd,
        javascriptreact = prettierd,
        css = prettierd,
        json = prettierd,
        html = prettierd,
        graphql = prettierd,
        lua = require("formatter.filetypes.lua").stylua,
      }
    }
  end,
}
