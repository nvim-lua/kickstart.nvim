return {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      suppressed_dirs = { "~/", "~/Downloads", "/" },
      use_git_branch = true,
      auto_restore_enabled = true,
      pre_cwd_changed_cmds = {
        "Neotree close"
      },
      -- pre_save_cmds = {
      --   "tabdo Neotree close"
      -- },
      -- post_save_cmds = {
      --   "tabdo Neotree"
      -- },
      -- pre_restore_cmds = {
      --   "tabdo Neotree close"
      -- },
      -- post_restore_cmds = {
      --   "tabdo Neotree"
      -- },
    }
  end
}
