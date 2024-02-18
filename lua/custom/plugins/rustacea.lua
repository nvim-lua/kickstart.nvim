return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  dependencies = {
    {
      'lvimuser/lsp-inlayhints.nvim',
      opts = {},
    },
  },
  ft = { 'rust' },
  keys = {
    {
      '<leader>dr',
      '<cmd>RustLsp debuggables<cr>',
      'Rust debug',
    },
  },
  config = function()
    vim.g.rustaceanvim = {
      inlay_hints = {
        highlight = 'NonText',
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        on_attach = function(client, bufnr)
          require('lsp-inlayhints').on_attach(client, bufnr)
        end,
      },
    }
  end,
}
