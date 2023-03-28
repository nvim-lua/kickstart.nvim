return {
  'zbirenbaum/copilot-cmp',
  dependencies = { 'zbirenbaum/copilot.lua', 'github/copilot.vim' },
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
