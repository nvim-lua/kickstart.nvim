return {
  'echasnovski/mini.comment',
  event = 'VeryLazy',
  opts = {
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
}
