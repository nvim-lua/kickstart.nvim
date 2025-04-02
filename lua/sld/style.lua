require('gruvbox-material').setup {
  italics = false, -- enable italics in general
  contrast = 'hard', -- set contrast, can be any of "hard", "medium", "soft"
  comments = {
    italics = false,
  },
  background = {
    transparent = true, -- set the background to transparent
  },
  float = {
    force_background = false, -- force background on floats even when background.transparent is set
    background_color = nil, -- set color for float backgrounds. If nil, uses the default color set
    -- by the color scheme
  },
  signs = {
    highlight = true, -- whether to highlight signs
  },
  customize = nil, -- customize the theme in any way you desire, see below what this
  -- configuration accepts
}
