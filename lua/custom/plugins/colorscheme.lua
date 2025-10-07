return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 999,
  config = function()
    vim.o.background = 'dark' -- or 'light'
    vim.cmd.colorscheme 'solarized'
    vim.keymap.set('n', '<leader>Scl', function()
      vim.o.background = 'light'
    end, { desc = '[S]et the [c]olorscheme background [l]ight' })
    vim.keymap.set('n', '<leader>Scd', function()
      vim.o.background = 'dark'
    end, { desc = '[S]et the [c]olorscheme background [d]ark' })
  end,
}
