-- Seamless nvim-split + zellij-pane navigation.
-- Replaces vim-tmux-navigator. smart-splits owns Ctrl-h/j/k/l and falls
-- through to `zellij action move-focus` when at a vim split edge.
return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  opts = {
    multiplexer_integration = 'zellij',
  },
  keys = {
    { '<C-h>', function() require('smart-splits').move_cursor_left() end,  desc = 'Focus left split/pane' },
    { '<C-j>', function() require('smart-splits').move_cursor_down() end,  desc = 'Focus down split/pane' },
    { '<C-k>', function() require('smart-splits').move_cursor_up() end,    desc = 'Focus up split/pane' },
    { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Focus right split/pane' },
  },
}
