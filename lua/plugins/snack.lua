return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      -- scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },

      image = {
        enabled = true,       -- force enable even if terminal isn't fully supported
        backend = "magick",   -- fallback backend for images
        diagnostics = false,   -- keep this on so you can see setup issues
        auto_preview = false, -- if you don’t want inline previews on hover
        view = "ascii",       -- can be "image", "ascii", or "none"
        max_height = 30,      -- in rows
        max_width = 50,       -- in columns
        use_dither = false,   -- optional: enable dithered rendering
      },
    },
  },
}
