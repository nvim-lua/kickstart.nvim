-- including github-nvim-theme.
-- currently the latest stable tag is v0.0.7
-- https://github.com/projekt0n/github-nvim-theme

return {
"projekt0n/github-nvim-theme",
config = function()
require("github-theme").setup({
theme_style = "dark_default",
comment_style = "italic",
keyword_style = "NONE",
function_style = "NONE",
variable_style = "NONE",
sidebars = {"qf", "vista_kind", "terminal", "packer"},
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = {hint = "orange", error = "#ff0000"},

  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
      DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
      -- this will remove the highlight groups
      TSField = {},
    }
  end
})
end,
setup = function()
require("lazy").loader("github-nvim-theme")
end
}