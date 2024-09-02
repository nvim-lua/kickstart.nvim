-- https://github.com/hedyhli/outline.nvim
return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    { '<leader>to', '<cmd>Outline<CR>', desc = '[T]oggle [O]utline' },
  },
  opts = {
    -- Your setup opts here
  },
}
