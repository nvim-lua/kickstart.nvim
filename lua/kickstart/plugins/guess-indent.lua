local gh = require('kickstart.util').gh

vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}
