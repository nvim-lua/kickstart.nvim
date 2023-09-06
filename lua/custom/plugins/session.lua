return {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      post_restore_cmds = {
        function()
          require('nvim-tree.api').tree.toggle(false, true)
        end
      }
    }
  end
}
