if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.9
  vim.api.nvim_create_user_command('FullscreenToggle',
    function (opts)
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end,
    {}
  )

  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_scroll_animation_length = 0.3

  vim.g.neovide_cursor_vfx_mode = "railgun"
end
