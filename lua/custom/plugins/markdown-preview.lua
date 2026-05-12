-- Live browser preview on `:MarkdownPreview`.
-- Build via the plugin's helper so it doesn't dirty yarn.lock and break Lazy updates.
return {
  'iamcco/markdown-preview.nvim',
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  init = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = '[M]arkdown [P]review' },
  },
}
