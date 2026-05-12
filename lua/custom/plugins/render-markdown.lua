-- In-buffer markdown rendering (headings, lists, code blocks, tables).
-- Applies to markdown buffers, LSP hover docs, and noice popups.
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown', 'codecompanion' },
  opts = {
    file_types = { 'markdown', 'codecompanion' },
    completions = { lsp = { enabled = true } },
  },
}
