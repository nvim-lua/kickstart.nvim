return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'modern',
    icons = {
      keys = {
        BS = '󰁮 ',
      },
    },
  },
  keys = {
    { '<leader>c', group = '[C]ode' },
    { '<leader>d', group = '[D]ebugger' },
    { '<leader>h', group = '[H]arpoon' },
    { '<leader>r', group = '[R]ename' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]rouble' },
    { '<leader>w', group = '[W]orkspace' },
  },
}
