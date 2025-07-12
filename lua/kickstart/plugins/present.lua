return {
  {
    dir = '~/Escritorio/code/plugins/present.nvim/',
    config = function()
      local todo = require 'present'
      todo.setup {}
    end,
  },
}
