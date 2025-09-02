-- LSP Keymaps Configuration
local M = {}

function M.setup()
  -- Setup keymaps when LSP attaches to a buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach-keymaps', { clear = true }),
    callback = function(event)
      -- Helper function to define keymaps
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Navigation keymaps (using kickstart.nvim patterns)
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype definition')
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      
      -- Symbol operations
      map('grn', vim.lsp.buf.rename, '[G]oto [R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto code [A]ction', { 'n', 'x' })
      map('gO', require('telescope.builtin').lsp_document_symbols, '[G]oto [O]pen document symbols')
      map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[G]oto [W]orkspace symbols')
      
      -- Documentation
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      
      -- Formatting
      map('<leader>f', function()
        vim.lsp.buf.format { async = true }
      end, '[F]ormat buffer')
      
      -- The following keymaps are available but not mapped by default:
      -- vim.lsp.buf.signature_help - Show function signature help
      -- vim.lsp.buf.add_workspace_folder - Add workspace folder
      -- vim.lsp.buf.remove_workspace_folder - Remove workspace folder
      -- vim.lsp.buf.list_workspace_folders - List workspace folders
      
      -- Optional: Add a message when LSP attaches
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client then
        vim.notify('LSP attached: ' .. client.name, vim.log.levels.INFO)
      end
    end,
  })
  
  -- Diagnostic keymaps (available globally, not just when LSP attaches)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
end

return M