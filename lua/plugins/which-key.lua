-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- set which-key layout to look like 'helix'
    preset = 'helix',
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = false },
    sort = { 'local', 'order', 'group', 'desc', 'case', 'alphanum', 'mod' },

    plugins = {
      spelling = { enabled = false },
    },

    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>f', group = '[F]uzzy-find', mode = { 'n', 'v' } },
      { '<leader>g', group = '[G]rep', mode = { 'n', 'v' } },
      { '<leader>G', group = '[G]it', mode = { 'n', 'v' } },
      { '<leader>l', group = '[L]SP', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>d', group = '[D]iangostic' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  },
}
