return {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_use_git_branch = true,
      auto_session_enable_last_session = true,
      pre_save_cmds = {
        "NeoTreeClose"
      },
      post_save_cmds = {
        "NeoTreeReveal"
      },
      pre_restore_cmds = {
        "NeoTreeClose"
      },
      post_restore_cmds = {
        "NeoTreeReveal"
      },
    }
  end
}
