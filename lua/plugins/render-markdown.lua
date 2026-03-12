return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.nvim', -- for mini.icons, to use icons during render
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ft = { 'markdown', 'quarto' },
  keys = {
    {
      '<leader>tr',
      function()
        require('render-markdown').toggle()
      end,
      desc = '[T]oggle [R]enderMarkdown',
    },
  },
  opts = {
    -- for more info read https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
    enabled = false,
    render_modes = { 'n', 'c', 't', 'v', 'V', '\22' },
    completions = { lsp = { enabled = true } },
  },
}
