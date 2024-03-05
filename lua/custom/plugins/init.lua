-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  {
    'jubnzv/mdeval.nvim',
    event = 'VeryLazy',
    opt = function()
      return vim.g.markdown_fenced_languages == { 'python', 'cpp' }
    end,
  },
  {
    'ixru/nvim-markdown',
    event = 'VeryLazy',
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
