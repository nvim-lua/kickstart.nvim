-- File operations plugin
return {
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function()
      require('dressing').setup({
        input = {
          enabled = true,
          default_prompt = 'Input:',
          prompt_align = 'left',
          insert_only = true,
          start_in_insert = true,
          anchor = 'SW',
          border = 'rounded',
          relative = 'cursor',
          prefer_width = 40,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          buf_options = {},
          win_options = {
            winblend = 10,
            wrap = false,
          },
          mappings = {
            n = {
              ['<Esc>'] = 'Close',
              ['<CR>'] = 'Confirm',
            },
            i = {
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
              ['<Up>'] = 'HistoryPrev',
              ['<Down>'] = 'HistoryNext',
            },
          },
        },
      })
    end,
  },
}