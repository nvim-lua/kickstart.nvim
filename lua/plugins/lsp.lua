return {
  'neovim/nvim-lspconfig', -- still needed for default server configs
  dependencies = {
    'saghen/blink.cmp',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- Inject blink.cmp capabilities into ALL servers globally.
    -- This replaces what the old mason-lspconfig handler was doing per-server.
    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
    })

    local detach_augroup = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true })

    -- LspAttach: keymaps only. Server setup is handled by vim.lsp.enable in setup/lsp.lua
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grr', function() require('telescope.builtin').lsp_references() end, '[G]oto [R]eferences')
        map('gri', function() require('telescope.builtin').lsp_implementations() end, '[G]oto [I]mplementation')
        map('grd', function() require('telescope.builtin').lsp_definitions() end, '[G]oto [D]efinition')
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gO', function() require('telescope.builtin').lsp_document_symbols() end, 'Open Document Symbols')
        map('gW', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, 'Open Workspace Symbols')
        map('grt', function() require('telescope.builtin').lsp_type_definitions() end, '[G]oto [T]ype Definition')
        map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<leader>n', vim.lsp.buf.rename, '[R]e[n]ame')

        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local hl_group = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = detach_augroup,
            buffer = event.buf,
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>lh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[L]SP Toggle Inlay [H]ints')
        end
      end,
    })
  end,
}
