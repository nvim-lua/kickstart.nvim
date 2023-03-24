return {
  'tzachar/cmp-tabnine',
  build = './install.sh',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = 'tabnine',
      option = {},
    })
    cmp.setup(config)
  end,
}
