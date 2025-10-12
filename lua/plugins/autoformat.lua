-- lua/plugins/autoformat.lua
-- Automatically format Go code on save and when idle after changes

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    ---------------------------------------------------------------------------
    -- 🧹 Format on save
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        -- Runs both gopls and none-ls formatters in order
        vim.lsp.buf.format({ async = false })
      end,
    })

    ---------------------------------------------------------------------------
    -- ⚡ Auto-format when idle (after you stop typing)
    ---------------------------------------------------------------------------
    local format_timer = vim.loop.new_timer()

    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      pattern = "*.go",
      callback = function()
        -- Cancel previous pending format
        format_timer:stop()

        -- Wait 1.5 seconds after the last change before formatting
        format_timer:start(1500, 0, vim.schedule_wrap(function()
          -- Only format if the buffer still exists and is listed
          local bufnr = vim.api.nvim_get_current_buf()
          if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modifiable then
            vim.lsp.buf.format({ async = true })
          end
        end))
      end,
    })

    ---------------------------------------------------------------------------
    -- 🧪 Optional: run `goimports` and quick test on save
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.go",
      callback = function()
        -- Automatically fix imports using goimports if available
        vim.fn.jobstart({ "goimports", "-w", vim.fn.expand("%:p") }, {
          on_exit = function()
            -- Optionally, trigger a quick test run for feedback
            vim.fn.jobstart({ "go", "test", "./..." }, {
              cwd = vim.fn.getcwd(),
              stdout_buffered = true,
              stderr_buffered = true,
              on_stdout = function(_, data)
                if data then
                  vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "go test" })
                end
              end,
              on_stderr = function(_, data)
                if data then
                  vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR, { title = "go test" })
                end
              end,
            })
          end,
        })
      end,
    })
  end,
}

