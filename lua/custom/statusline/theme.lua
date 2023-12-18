local statusline_bg = nil
local merge_tb = vim.tbl_deep_extend

local theme = require('custom.statusline.themes.tokyodark')
local colors = theme.base_30

local Lsp_highlights = {
  St_lspError = {
    fg = colors.red,
    bg = statusline_bg,
  },

  St_lspWarning = {
    fg = colors.yellow,
    bg = statusline_bg,
  },

  St_LspHints = {
    fg = colors.purple,
    bg = statusline_bg,
  },

  St_LspInfo = {
    fg = colors.green,
    bg = statusline_bg,
  },
}

local M = {}

M.theme = {
  StatusLine = {
    bg = statusline_bg,
  },

  St_gitIcons = {
    fg = colors.light_grey,
    bg = statusline_bg,
    bold = true,
  },

  St_LspStatus = {
    fg = colors.nord_blue,
    bg = statusline_bg,
  },

  St_LspProgress = {
    fg = colors.green,
    bg = statusline_bg,
  },

  St_LspStatus_Icon = {
    fg = colors.black,
    bg = colors.nord_blue,
  },

  St_EmptySpace = {
    fg = colors.grey,
    bg = colors.lightbg,
  },

  St_EmptySpace2 = {
    fg = colors.grey,
    bg = statusline_bg,
  },

  St_file_info = {
    bg = colors.lightbg,
    fg = colors.white,
  },

  St_file_sep = {
    bg = statusline_bg,
    fg = colors.lightbg,
  },

  St_cwd_icon = {
    fg = colors.one_bg,
    bg = colors.red,
  },

  St_cwd_text = {
    fg = colors.white,
    bg = colors.lightbg,
  },

  St_cwd_sep = {
    fg = colors.red,
    bg = statusline_bg,
  },

  St_pos_sep = {
    fg = colors.green,
    bg = colors.lightbg,
  },

  St_pos_icon = {
    fg = colors.black,
    bg = colors.green,
  },

  St_pos_text = {
    fg = colors.green,
    bg = colors.lightbg,
  },
}

M.theme = merge_tb("force", M.theme, Lsp_highlights)

local function genModes_hl(modename, col)
  M.theme["St_" .. modename .. "Mode"] = { fg = colors.black, bg = colors[col], bold = true }
  M.theme["St_" .. modename .. "ModeSep"] = { fg = colors[col], bg = colors.grey }
end

-- add mode highlights
genModes_hl("Normal", "nord_blue")

genModes_hl("Visual", "cyan")
genModes_hl("Insert", "dark_purple")
genModes_hl("Terminal", "green")
genModes_hl("NTerminal", "yellow")
genModes_hl("Replace", "orange")
genModes_hl("Confirm", "teal")
genModes_hl("Command", "green")
genModes_hl("Select", "blue")

return M.theme
