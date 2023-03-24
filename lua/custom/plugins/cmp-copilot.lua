return {
  'hrsh7th/cmp-copilot',
  config = function()
    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = 'copilot',
      option = {},
    })
    cmp.setup(config)
  end,
}
