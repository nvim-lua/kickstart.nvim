local spec = require('kickstart.plugins.gitsigns')[1]

spec.opts.signs = {
  add = { text = '+' },
  change = { text = '~' },
  delete = { text = '_' },
  topdelete = { text = '‾' },
  changedelete = { text = '~' },
}

return spec
