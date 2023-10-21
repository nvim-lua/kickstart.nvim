-- credits to original theme for existing https://github.com/nealmckee/penumbra
-- This is a modified version of it

local M = {}

M.base_30 = {
  white = "#FFFDFB",
  darker_black = "#2b2e33",
  black = "#303338",
  black2 = "#3a3d42",
  one_bg = "#3d4045",
  one_bg2 = "#484b50",
  one_bg3 = "#515459",
  grey = "#5c5f64",
  grey_fg = "#676a6f",
  grey_fg2 = "#72757a",
  light_grey = "#7d8085",
  red = "#CA7081",
  baby_pink = "#E18163",
  pink = "#D07EBA",
  green = "#4EB67F",
  vibrant_green = "#50B584",
  nord_blue = "#6e8dd5",
  blue = "#8C96EC",
  yellow = "#c1ad4b",
  sun = "#9CA748",
  purple = "#ac78bd",
  dark_purple = "#8C96EC",
  orange = "#CE9042",
  teal = "#00a6c8",
  cyan = "#00B3C2",
  line = "#3E4044",
  statusline_bg = "#34373c",
  lightbg = "#484b50",
  pmenu_bg = "#4EB67F",
  folder_bg = "#8C96EC",
}

M.base_16 = {
  base00 = "#303338",
  base01 = "#3a3d42",
  base02 = "#3d4045",
  base03 = "#484b50",
  base04 = "#515459",
  base05 = "#CECECE",
  base06 = "#F2E6D4",
  base07 = "#FFF7ED",
  base08 = "#999999",
  base09 = "#BE85D1",
  base0A = "#CA7081",
  base0B = "#4ec093",
  base0C = "#D68B47",
  base0D = "#7A9BEC",
  base0E = "#BE85D1",
  base0F = "#A1A641",
}

M.polish_hl = {
  ["@field.key"] = {
    fg = M.base_30.red,
  },

  Constant = {
    fg = M.base_30.red,
  },

  ["@punctuation.bracket"] = {
    fg = M.base_16.base08,
  },

  ["@constructor"] = {
    fg = M.base_30.orange,
  },

  ["@parameter"] = {
    fg = M.base_30.orange,
  },

  Operator = {
    fg = M.base_30.cyan,
  },

  ["@tag.delimiter"] = {
    fg = M.base_16.base08,
  },

  ["@tag.attribute"] = {
    link = "@annotation",
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "penumbra_dark")

return M
