-- Credits to original https://github.com/altercation/solarized
-- This is modified version of it

local M = {}

M.base_30 = {
  white = "#abb2bf",
  darker_black = "#002530",
  black = "#002b36", --  nvim bg
  black2 = "#06313c",
  one_bg = "#0a3540", -- real bg of onedark
  one_bg2 = "#133e49",
  one_bg3 = "#1b4651",
  grey = "#28535e",
  grey_fg = "#325d68",
  grey_fg2 = "#3c6772",
  light_grey = "#446f7a",
  red = "#dc322f",
  baby_pink = "#eb413e",
  pink = "#d33682",
  line = "#0f3a45", -- for lines like vertsplit
  green = "#859900",
  vibrant_green = "#b2c62d",
  nord_blue = "#197ec5",
  blue = "#268bd2",
  yellow = "#b58900",
  sun = "#c4980f",
  purple = "#6c71c4",
  dark_purple = "#5d62b5",
  teal = "#519ABA",
  orange = "#cb4b16",
  cyan = "#2aa198",
  statusline_bg = "#042f3a",
  lightbg = "#113c47",
  pmenu_bg = "#268bd2",
  folder_bg = "#268bd2",
}

M.base_16 = {
  base00 = "#002b36",
  base01 = "#06313c",
  base02 = "#0a3540",
  base03 = "#133e49",
  base04 = "#1b4651",
  base05 = "#93a1a1",
  base06 = "#eee8d5",
  base07 = "#fdf6e3",
  base08 = "#dc322f",
  base09 = "#cb4b16",
  base0A = "#b58900",
  base0B = "#859900",
  base0C = "#2aa198",
  base0D = "#268bd2",
  base0E = "#6c71c4",
  base0F = "#d33682",
}

M.type = "dark"

M = require("base46").override_theme(M, "solarized_dark")

return M
