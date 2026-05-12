-- Persistent floating/split terminals. Replaces the hand-rolled FloatingTerm.
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { 'ToggleTerm', 'TermExec', 'ToggleTermSendCurrentLine', 'ToggleTermSendVisualLines' },
  keys = {
    { '<leader>t', '<cmd>ToggleTerm direction=float<cr>',      desc = 'Toggle floating terminal' },
    { '<leader>T', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Toggle horizontal terminal' },
  },
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return math.floor(vim.o.lines * 0.3)
      else
        return math.floor(vim.o.columns * 0.4)
      end
    end,
    open_mapping = [[<c-\>]],
    direction = 'float',
    float_opts = { border = 'rounded' },
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    shade_terminals = true,
  },
}
