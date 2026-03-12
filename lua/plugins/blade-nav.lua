return {
  'ricardoramirezr/blade-nav.nvim',
  dependencies = {
    'saghen/blink.cmp',
  },
  ft = { 'blade', 'php' }, -- optional, improves startup time
  opts = {
    -- This applies for nvim-cmp and coq, for blink refer to the configuration of this plugin
    close_tag_on_complete = true, -- default: true
  },
}
