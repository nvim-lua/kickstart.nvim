return {
  "Shatur/neovim-session-manager",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('session_manager').setup({})
  end
}
