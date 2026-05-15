return {
  'tzachar/local-highlight.nvim',

  dependencies = {
    'folke/snacks.nvim',
  },

  config = function()
    require('local-highlight').setup {
      file_types = { 'xyz' },
      highlight_single_match = false,
      cw_hlgroup = 'Search',
      insert_mode = true,
    }

    vim.keymap.set('n', '<leader>ph', vim.cmd.LocalHighlightToggle, { expr = false, silent = true, desc = 'Toggle local-highlight.nvim' })
  end,
}
