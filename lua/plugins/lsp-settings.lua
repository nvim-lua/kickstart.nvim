-- ~/.config/nvim/lua/plugins/custom-lsp.lua
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Setup Mason
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- LSPs to enable
      local servers = {
        'lua_ls',
        'ols',
        'zls',
        'clangd',
        'jsonls',
        'html',
        'rust_analyzer',
        'jdtls',
        'eslint',
        'pyright',
      }

      local lspconfig = require 'lspconfig'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for _, server in ipairs(servers) do
        lspconfig[server].setup {
          capabilities = capabilities,
        }
      end

      -- Autocommand for keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = 'Lsp: ' .. desc })
          end

          local tele = require 'telescope.builtin'

          map('gd', tele.lsp_definitions, 'Goto Definition')
          map('<leader>fs', tele.lsp_document_symbols, 'Doc Symbols')
          map('<leader>fS', tele.lsp_dynamic_workspace_symbols, 'Dynamic Symbols')
          map('<leader>ft', tele.lsp_type_definitions, 'Goto Type')
          map('<leader>fr', tele.lsp_references, 'Goto References')
          map('<leader>fi', tele.lsp_implementations, 'Goto Impl')

          map('K', vim.lsp.buf.hover, 'Hover Docs')
          map('<leader>E', vim.diagnostic.open_float, 'Diagnostics')
          map('<leader>k', vim.lsp.buf.signature_help, 'Signature Help')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          map('<leader>wf', function()
            vim.lsp.buf.format { async = true }
          end, 'Format')

          vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Lsp: Code Action' })
        end,
      })
    end,
  },
}
