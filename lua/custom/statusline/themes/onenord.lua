-- Credits to original https://github.com/arcticicestudio/nord-vim
-- This is modified version of it

local M = {}

M.base_30 = {
  white = "#D8DEE9",
  darker_black = "#252b37",
  black = "#2a303c", --  nvim bg
  black2 = "#2f3541",
  one_bg = "#343a46",
  one_bg2 = "#3e4450",
  one_bg3 = "#484e5a",
  grey = "#4d535f",
  grey_fg = "#545a66",
  grey_fg2 = "#595f6b",
  light_grey = "#606672",
  red = "#d57780",
  baby_pink = "#de878f",
  pink = "#da838b",
  line = "#414753", -- for lines like vertsplit
  green = "#A3BE8C",
  vibrant_green = "#afca98",
  blue = "#7797b7",
  nord_blue = "#81A1C1",
  yellow = "#EBCB8B",
  sun = "#e1c181",
  purple = "#aab1be",
  dark_purple = "#B48EAD",
  teal = "#6484a4",
  orange = "#e39a83",
  cyan = "#9aafe6",
  statusline_bg = "#333945",
  lightbg = "#3f4551",
  pmenu_bg = "#A3BE8C",
  folder_bg = "#7797b7",
}

M.base_16 = {
  base00 = "#2a303c",
  base01 = "#3B4252",
  base02 = "#434C5E",
  base03 = "#4C566A",
  base04 = "#566074",
  base05 = "#bfc5d0",
  base06 = "#c7cdd8",
  base07 = "#ced4df",
  base08 = "#d57780",
  base09 = "#e39a83",
  base0A = "#EBCB8B",
  base0B = "#A3BE8C",
  base0C = "#97b7d7",
  base0D = "#81A1C1",
  base0E = "#B48EAD",
  base0F = "#d57780",
}

M.type = "dark"

M = require("base46").override_theme(M, "onenord")

return M
