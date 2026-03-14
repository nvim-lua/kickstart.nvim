return {
  -- This tells Lazy to use nvim-lspconfig as the base
  'neovim/nvim-lspconfig',
  config = function()
    -- Use the new 0.11+ syntax to avoid the deprecation warning
    vim.lsp.config('gdscript', {
      cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
      filetypes = { 'gdscript', 'gdscript3' },
      root_markers = { 'project.godot', '.git' },
    })

    -- Actually turn on the engine
    vim.lsp.enable 'gdscript'
  end,
}
