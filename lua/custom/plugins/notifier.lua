return {
  'vigoux/notifier.nvim',
  config = function()
    require('notifier').setup {
      {
        ignore_messages = {}, -- Ignore message from LSP servers with this name
        components = { -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
          'nvim', -- Nvim notifications (vim.notify and such)
          'lsp', -- LSP status updates
        },
        notify = {
          clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
          min_level = vim.log.levels.INFO, -- Minimum log level to print the notification
        },
        component_name_recall = false, -- Whether to prefix the title of the notification by the component name
        zindex = 50, -- The zindex to use for the floating window. Note that changing this value may cause visual bugs with other windows overlapping the notifier window.
      },
    }
  end,
}
