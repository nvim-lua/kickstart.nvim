-- Codam header
return {
  config = function()
    require('codamheader').setup {
      auto_update = true,
      user = 'dponte',
      mail = 'dponte@student.codam.nl',
      git = {
        enabled = false,
        bin = 'git',
        user_global = true,
        email_global = true,
      },
      exascii_left = false,
    }
  end,
}
