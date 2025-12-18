return {
  {
    'andweeb/presence.nvim',
    lazy = false,
    config = function()
      require('presence').setup {
        auto_update = true,
        neovim_image_text = '(•̀⤙•́)',
        main_image = 'file', -- ("neovim" or "file")
        debounce_timeout = 10,
        enable_line_number = true,
        buttons = true,
        show_time = true,

        editing_text = 'Editing %s',
        file_explorer_text = 'Browsing %s',
        git_commit_text = 'Committing changes',
        plugin_manager_text = 'Managing plugins',
        reading_text = 'Reading %s',
        workspace_text = 'Working on %s',
        line_number_text = 'Line %s out of %s',
      }
    end,
  },
}
