return {
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()

      -- Отключаем стандартный текст справа (virtual_text), чтобы не дублировалось
      vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = true, -- Включаем линии
      }

      -- Хоткей, чтобы переключать режим (иногда линии мешают коду)
      vim.keymap.set('', '<leader>l', require('lsp_lines').toggle, { desc = 'Toggle LSP Lines' })
    end,
  },
}
