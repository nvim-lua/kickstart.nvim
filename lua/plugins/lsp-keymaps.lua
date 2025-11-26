-- lua/plugins/lsp-keymaps.lua
return {
  -- Attach to the existing LSP config plugin
  'neovim/nvim-lspconfig',

  -- We just need this to run once; inside we create an LspAttach autocmd
  event = 'VeryLazy',

  config = function()
    -- Only define the autocmd once
    vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = 'UserLspKeymaps',
      callback = function(ev)
        local bufnr = ev.buf
        local opts = function(extra)
          return vim.tbl_extend('force', { buffer = bufnr, silent = true, noremap = true }, extra or {})
        end

        -- Core LSP maps
        vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<CR>', opts { desc = 'LSP Info' })

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,       opts { desc = 'Go to Definition' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references,       opts { desc = 'References' })
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation,   opts { desc = 'Go to Implementation' })
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition,  opts { desc = 'Go to Type Definition' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,      opts { desc = 'Go to Declaration' })
        vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help,   opts { desc = 'Signature Help' })

        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts { desc = 'Signature Help' })

        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts { desc = 'Code Action' })

        -- Rename symbol
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts { desc = 'Rename' })

        -- Rename file via Snacks, but **safely**
        vim.keymap.set('n', '<leader>cR', function()
          local ok, snacks = pcall(require, 'snacks')
          if ok and snacks.rename and snacks.rename.rename_file then
            snacks.rename.rename_file()
          else
            print 'Snacks rename not available'
          end
        end, opts { desc = 'Rename File' })
      end,
    })
  end,
}

