return {
  'ellisonleao/carbon-now.nvim',
  lazy = true,
  cmd = 'CarbonNow',
  -- @param opts cn.ConfigSchema
  opts = {
    base_url = 'https://carbon.now.sh/',
    open_cmd = 'xdg-open',
    options = {
      bg = 'gray',
      drop_shadow_blur = '68px',
      drop_shadow = false,
      drop_shadow_offset_y = '20px',
      font_family = 'JetBrains Mono',
      font_size = '16px',
      line_height = '124%',
      line_numbers = true,
      theme = 'verminal',
      titlebar = 'VIM 🚀',
      watermark = false,
      width = '680',
      window_theme = 'sharp',
      padding_horizontal = '0px',
      padding_vertical = '0px',
    },
  },
}
