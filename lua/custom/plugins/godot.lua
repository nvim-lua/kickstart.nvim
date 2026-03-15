-- Lowkey, this could have been like one line in the root init.lua, however, we keeping things modular
return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config('gdscript', {
      cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
      filetypes = { 'gdscript' },
      root_markers = { 'project.godot', '.git' },
    })

    -- Actually turn on the engine
    vim.lsp.enable 'gdscript'
  end,
}
