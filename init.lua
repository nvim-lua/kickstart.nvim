print("Loading Neovim Configuration..")
if vim.g.vscode then
  -- VSCode extension
  print("Loading VSCode Neovim Configuration..")
  require 'vscode-init'
else
  require 'cli-init'
end

