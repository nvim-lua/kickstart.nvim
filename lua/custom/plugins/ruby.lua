return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'ruby-lsp',
        'erb-formatter',
      },
    },
  },
  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              extended_filetypes = { ruby = { 'rails' } },
            },
          },
        },
      },
    },
  },
}
