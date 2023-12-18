-- Thanks to https://github.com/savq/melange for existing
-- This is a modified version of it

local M = {}

M.base_30 = {
  white = "#ECE1D7",
  darker_black = "#241f1a",
  black = "#2A2520", -- nvim bg
  black2 = "#342f2a",
  one_bg = "#39342f",
  one_bg2 = "#433e39",
  one_bg3 = "#4d4843",
  grey = "#57524d",
  grey_fg = "#605b56",
  grey_fg2 = "#6b6661",
  light_grey = "#75706b",
  red = "#B65C60",
  baby_pink = "#CE9BCB",
  pink = "#B65C60",
  line = "#39342f", -- for lines like vertsplit
  green = "#86A3A3",
  vibrant_green = "#99D59D",
  nord_blue = "#88B3B2",
  blue = "#9AACCE",
  yellow = "#e3b865",
  sun = "#EBC06D",
  purple = "#c47fd5",
  dark_purple = "#b570c6",
  teal = "#697893",
  orange = "#E49B5D",
  firered = "#F17C64",
  cyan = "#bbcdef",
  statusline_bg = "#312c27",
  lightbg = "#433e39",
  pmenu_bg = "#86A3A3",
  folder_bg = "#697893",
}

M.base_16 = {
  base00 = "#2A2520",
  base01 = "#39342f",
  base02 = "#433e39",
  base03 = "#4d4843",
  base04 = "#57524d",
  base05 = "#ECE1D7",
  base06 = "#e3d8ce",
  base07 = "#d8cdc3",
  base08 = "#ECE1D7",
  base09 = "#86A3A3",
  base0A = "#99D59D",
  base0B = "#9AACCE",
  base0C = "#EBC06D",
  base0D = "#EBC06D",
  base0E = "#E49B5D",
  base0F = "#8E733F",
}

M.type = "dark"

M.polish_hl = {
  ["@field"] = { fg = M.base_30.white },
  ["@field.key"] = { fg = M.base_30.white },

  ["@function.macro"] = {
    fg = M.base_30.vibrant_green,
  },

  Include = {
    fg = M.base_30.vibrant_green,
  },

  Operator = {
    fg = M.base_30.firered,
  },

  Boolean = {
    fg = M.base_30.purple
  }
}

M = require("base46").override_theme(M, "melange")

return M
