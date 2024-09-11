return {
  'numToStr/Comment.nvim',

  config = function()
    require('Comment').setup {
      opleader = {
        ---Line-comment keymap
        line = '<leader>/',
      },
      toggler = {
        line = '<leader>/',
      },
    }
  end,

  lazy = false,
}
