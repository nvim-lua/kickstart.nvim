-- Blink.cmp - Modern completion plugin
return {
  'saghen/blink.cmp',
  lazy = false, -- Lazy loading handled internally
  dependencies = {
    'giuxtaposition/blink-cmp-copilot',
  },
  version = 'v0.*', -- Use stable releases
  config = function()
    require('plugins.config.blink').setup()
  end,
}