-- Highlight comment keywords like:

-- PERF
-- HACK
-- TODO
-- NOTE
-- FIX
-- WARNING
-- TEST

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    local colors = require('dracula').colors()

    require('todo-comments').setup({
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority

      TODO = { icon = " ", color = "info" },
      PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      HACK = { icon = "✇ ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      NOTE = { icon = "✐", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },

      gui_style = {
        fg = "NONE",         -- The gui style to use for the fg highlight group.
        bg = "BOLD",         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults

      highlight = {
        multiline = true,         -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,   -- extra lines that will be re-evaluated when changing a line
        before = "",              -- "fg" or "bg" or empty
        keyword = "bg",           -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",             -- "fg" or "bg" or empty
        pattern = [[(KEYWORDS)]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,     -- uses treesitter to match keywords in comments only
        max_line_len = 400,       -- ignore lines longer than this
        exclude = {},             -- list of file types to exclude highlighting
      },

      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = colors.red,
        warning = colors.yellow,
        info = colors.cyan,
        hint = colors.purple,
        default = colors.pink,
        test = colors.green,
      },

      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[(KEYWORDS)]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    })
  end
}
