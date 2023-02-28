return {
  'petertriho/nvim-scrollbar',
  config = function()
    require("scrollbar").setup({
      handle = {text = "  "},
      marks = {
        Search = {text = {"-- ", "== "}},
        Error = {text = {" ", " "}},
        Warn = {text = {" ", " "}},
        Info = {text = {" ", " "}},
        Hint = {text = {" ", " "}},
        Misc = {text = {"-- ", "== "}}
      }
    })
  end
}
