return {
  { -- Shows keybindings as you go
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
      },
      spec = {
        { '<leader>a', group = '[A]vante' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>l', group = '[L]LM Assist' },
        { '<leader>l9', group = 'Tab[9]' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>p', group = '[P] Explore', mode = { 'n' } },
        { '<leader>f', group = '[F]ind/Grep' },
        { '<leader>i', group = '[I]ndent' },
      },
    },
  },
}
