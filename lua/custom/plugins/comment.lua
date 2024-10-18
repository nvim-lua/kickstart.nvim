return {
  'numToStr/Comment.nvim',
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      -- Ensure commentstring is set properly for TSX and JSX files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'javascriptreact', 'typescriptreact' },
        callback = function()
          -- Use JSX-style comments in TSX/JSX files
          vim.bo.commentstring = '{/* %s */}'
        end,
      }),
    }
  end,
}
