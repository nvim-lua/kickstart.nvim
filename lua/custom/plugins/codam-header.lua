return {
  'f-ras/codam-header.nvim',
  cmd = { 'Stdheader' },
  opts = {
    auto_update = true, -- Update header when saving.
    user = 'dponte',
    mail = 'dponte@student.codam.nl', -- Your mail.
    -- add other options.
  },
  config = function(_, opts)
    require('codamheader').setup(opts)
  end,
}

