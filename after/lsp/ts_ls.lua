return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
  },
  init_options = {
    plugins = {
      {
        languages = { 'vue' },
        location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server',
        name = '@vue/typescript-plugin',
      },
    },
  },
}
