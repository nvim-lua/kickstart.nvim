---@diagnostic disable: undefined-global
-- LSP keymaps

local M = {}

function M.setup(bufnr)
  local keymaps = {
    -- Go to definitions
    { mode = 'n', lhs = 'gd', rhs = function() require('telescope.builtin').lsp_definitions() end, opts = { desc = 'LSP: Go to definition' } },
    { mode = 'n', lhs = 'gr', rhs = function() require('telescope.builtin').lsp_references() end, opts = { desc = 'LSP: Find references' } },
    { mode = 'n', lhs = 'gI', rhs = function() require('telescope.builtin').lsp_implementations() end, opts = { desc = 'LSP: Go to implementation' } },
    { mode = 'n', lhs = 'gy', rhs = function() require('telescope.builtin').lsp_type_definitions() end, opts = { desc = 'LSP: Go to type definition' } },

    -- Symbol navigation
    { mode = 'n', lhs = '<leader>ls', rhs = function()
      require('telescope.builtin').lsp_document_symbols({ position_encoding = 'utf-16' })
    end, opts = { desc = 'LSP: Document symbols' } },
    { mode = 'n', lhs = '<leader>lS', rhs = function()
      local status_ok, _ = pcall(function()
        require('telescope.builtin').lsp_dynamic_workspace_symbols({
          position_encoding = 'utf-16',
          show_line = true,
          fname_width = 50,
          symbol_width = 35,
          attach_mappings = function(prompt_bufnr)
            require("telescope.actions").select_default:replace(function()
              local entry = require("telescope.actions.state").get_selected_entry()
              if not entry then return end
              require("telescope.actions").close(prompt_bufnr)
              if entry.value and entry.value.filename then
                vim.cmd(string.format('edit %s', entry.value.filename))
                vim.api.nvim_win_set_cursor(0, {entry.value.lnum, entry.value.col})
              end
            end)
            return true
          end
        })
      end)
      if not status_ok then
        vim.notify("Workspace symbols not available for this language server", vim.log.levels.INFO)
      end
    end, opts = { desc = 'LSP: Workspace symbols' } },

    -- Code actions
    { mode = 'n', lhs = '<leader>lr', rhs = vim.lsp.buf.rename, opts = { desc = 'LSP: Rename symbol' } },
    { mode = 'n', lhs = '<leader>la', rhs = vim.lsp.buf.code_action, opts = { desc = 'LSP: Code action' } },
    { mode = 'n', lhs = '<leader>lf', rhs = function() vim.lsp.buf.format({ async = true }) end, opts = { desc = 'LSP: Format code' } },

    -- Documentation
    { mode = 'n', lhs = 'K', rhs = function() require('hover').hover() end, opts = { desc = 'Enhanced documentation (hover.nvim)' } },
  }

  -- Clear existing LSP keymaps for this buffer
  local lsp_maps = { 'gd', 'gr', 'gI', 'gy', 'K', '<leader>ls', '<leader>lS', '<leader>lr', '<leader>la', '<leader>lf' }
  for _, lhs in ipairs(lsp_maps) do
    pcall(vim.keymap.del, 'n', lhs, { buffer = bufnr })
  end

  -- Set keymaps with buffer local
  for _, mapping in ipairs(keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, vim.tbl_extend('force', mapping.opts, {
      buffer = bufnr,
      replace_keycodes = false,
      nowait = true,
      silent = true,
    }))
  end
end

return M
