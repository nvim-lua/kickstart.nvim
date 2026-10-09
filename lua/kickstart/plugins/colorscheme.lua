vim.pack.add { 'https://github.com/Mofiqul/vscode.nvim' }

require('vscode').setup {
  style = 'dark'
}

vim.cmd.colorscheme 'vscode'
