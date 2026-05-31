-- Folk Snacks
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    styles = {
      input = {
        relative = 'editor',
        row = 20,
      },
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    words = { enabled = true },
    -- image = {
    --   enabled = true,
    --   resolve = function(path, src)
    --     local api = require 'obsidian.api'
    --     if api.path_is_note(path) then
    --       return api.resolve_attachment_path(src)
    --     end
    --   end,
    -- },
  },
}
