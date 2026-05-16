return {
  -- other plugins
  {
    'Canop/nvim-bacon',
    config = function()
      require('bacon').setup {
        quickfix = {
          enabled = true, -- Enable Quickfix integration
          event_trigger = true, -- Trigger QuickFixCmdPost after populating Quickfix list
        },
      }
    end,
  },
}
