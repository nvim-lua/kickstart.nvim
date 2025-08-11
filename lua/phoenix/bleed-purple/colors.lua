local hsl = require('phoenix.utils.color').hsl

local Colors = {}

Colors.dark = {
  black = hsl(240, 7, 13),
  bblack = hsl(240, 7, 16),
  red = hsl(1, 83, 40),
  bred = hsl(1, 83, 50),
  bgreen = hsl(156, 100, 48),
  green = hsl(172, 100, 34),
  yellow = hsl(40, 100, 74),
  byellow = hsl(40, 100, 84),
  blue = hsl(220, 100, 56),
  bblue = hsl(220, 100, 66),
  magenta = hsl(264, 100, 64),
  bmagenta = hsl(264, 100, 72),
  cyan = hsl(180, 98, 26),
  bcyan = hsl(180, 100, 32),
  white = hsl(240, 7, 84),
  bwhite = hsl(240, 7, 94),
}

Colors.dark.status_bg = Colors.dark.black
Colors.dark.dimmed_text = hsl(240, 7, 25)

return Colors
