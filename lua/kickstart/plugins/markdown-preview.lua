return {
  -- install with yarn or npm
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    keys = {
      { '<leader>ms', '<Plug>MarkdownPreview', desc = 'Start Preview', ft = 'markdown', mode = 'n' },
      { '<leader>mS', '<Plug>MarkdownPreviewStop', desc = 'Stop Preview', ft = 'markdown', mode = 'n' },
      { '<leader>mt', '<Plug>MarkdownPreviewToggle', desc = 'Toggle Preview', ft = 'markdown', mode = 'n' },
    },
  },
}
