local gh = require('kickstart.util').gh

vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }
