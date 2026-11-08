-- [[ Markdown ]]
-- render-markdown draws headings, tables, code blocks and checkboxes inside
-- the editor. Toggle it with <leader>tm in a Markdown buffer.

require('render-markdown').setup {
  latex = { enabled = false }, -- would need the latex parser plus utftex/latex2text
}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user-markdown', { clear = true }),
  pattern = 'markdown',
  callback = function(args)
    vim.keymap.set('n', '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', { buffer = args.buf, desc = 'Toggle Markdown rendering' })
  end,
})
