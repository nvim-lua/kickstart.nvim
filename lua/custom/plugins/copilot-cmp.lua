return {
  'zbirenbaum/copilot-cmp',
  dependencies = { 'copilot.lua' },
  config = function()
    require('copilot_cmp').setup()
    local cmp = require 'cmp'
    local config = cmp.get_config()
    table.insert(config.sources, {
      name = 'copilot',
    })
    cmp.setup(config)
  end,
}
