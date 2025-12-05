return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 999,
  config = function()
    vim.o.background = 'dark' -- or 'light'
    vim.cmd.colorscheme 'solarized'
    vim.keymap.set('n', '<leader>tc', function()
      if vim.o.background == 'light' then
        vim.o.background = 'dark'
      else
        vim.o.background = 'light'
      end
    end, { desc = '[T]oggle the [c]olorscheme background' })
  end,
}
