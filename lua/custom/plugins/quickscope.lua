return {
  'unblevable/quick-scope',
  event = { 'VimEnter' }, -- Load plugin on VimEnter event
  config = function()
    -- Enable QuickScope highlighting
    vim.cmd [[
      let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    ]]
  end,
}
