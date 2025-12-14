-- UI and appearance plugins
return {
  -- Colorscheme
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme kanagawa'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Keybinding hints
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it' },
        { '<leader>x', group = 'Trouble/Xcode' },
        { '<leader>f', group = '[F]ind/Format' },
        { '<leader>u', group = '[U]I Toggles' },
        { '<leader>o', group = '[O]pencode' },
        { '<leader>y', group = '[Y]arn (Type Hierarchy)' },
      },
    },
  },

  -- Icons
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  { 'echasnovski/mini.icons', opts = {} },

  -- Gutter marks
  {
    'dimtion/guttermarks.nvim',
    event = 'VeryLazy',
  },
}
