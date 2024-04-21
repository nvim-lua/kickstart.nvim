-- use `nvim .` or `knv .` to open neovim with this active
return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  -- set keymap for opening Oil file explorer
  vim.keymap.set({ 'n' }, '<leader>oe', ':Oil<CR>', { desc = 'Open Oil file explorer', silent = true }),
}
