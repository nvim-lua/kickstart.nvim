-- ========================================================================
-- GIT INTEGRATION PLUGINS
-- ========================================================================
-- Git tools for version control
-- - Gitsigns: Git decorations and utilities
-- ========================================================================

return {
  -- Git signs in gutter and utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
