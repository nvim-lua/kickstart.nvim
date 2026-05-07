---@diagnostic disable: undefined-global
-- Telescope keymaps

return {
  -- Help
  { mode = 'n', lhs = '<leader>sh', rhs = function() require('telescope.builtin').help_tags() end, opts = { desc = 'Search: Help' } },
  { mode = 'n', lhs = '<leader>sk', rhs = function() require('telescope.builtin').keymaps() end, opts = { desc = 'Search: Keymaps' } },

  -- Files
  { mode = 'n', lhs = '<leader>sf', rhs = function() require('telescope.builtin').find_files() end, opts = { desc = 'Search: Files' } },
  { mode = 'n', lhs = '<leader>sr', rhs = function() require('telescope.builtin').oldfiles() end, opts = { desc = 'Search: Recent files' } },

  -- Text
  { mode = 'n', lhs = '<leader>sg', rhs = function() require('telescope.builtin').live_grep() end, opts = { desc = 'Search: Text in workspace' } },
  { mode = 'n', lhs = '<leader>sw', rhs = function() require('telescope.builtin').grep_string() end, opts = { desc = 'Search: Word under cursor' } },
  { mode = 'n', lhs = '<leader>/', rhs = function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, opts = { desc = 'Search: Text in buffer' } },
  { mode = 'n', lhs = '<leader>s/', rhs = function()
    require('telescope.builtin').live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, opts = { desc = 'Search: Text in open files' } },

  -- Workspace
  { mode = 'n', lhs = '<leader>sd', rhs = function() require('telescope.builtin').diagnostics() end, opts = { desc = 'Search: Diagnostics' } },
  { mode = 'n', lhs = '<leader>sb', rhs = function() require('telescope.builtin').buffers() end, opts = { desc = 'Search: Buffers' } },
}
