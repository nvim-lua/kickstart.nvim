return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      typescript = { { "dprint", "prettier" } },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      php = { "php-cs-fixer" },
      json = { "prettier" },
      -- Conform can also run multiple formatters sequentially
      python = { "isort", "black" },
    },
    -- LazyVim will merge the options you set here with builtin formatters.
    -- You can also define any custom formatters here.
    ---@type table<string,table>
    formatters = {
      injected = { options = { ignore_errors = true } },
      -- # Example of using dprint only when a dprint.json file is present
      dprint = {
        condition = function(ctx)
          return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        end,
      },
      prettier = {
        condition = function(ctx)
          return vim.fs.find({ ".prettierrc" }, { path = ctx.filename, upward = true })[1]
        end,
      },
      -- Example of using shfmt with extra args
      shfmt = {
        extra_args = { "-i", "2", "-ci" },
      },
    },
  },
}
