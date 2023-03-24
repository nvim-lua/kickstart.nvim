return {
  'hrsh7th/cmp-path',
  config = function()
    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = 'path',
      option = {},
    })
    cmp.setup(config)
  end,
}
