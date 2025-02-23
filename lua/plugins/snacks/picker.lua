return {
  picker = {
    sources = {
      explorer = {
        tree = true,
        watch = true,
        diagnostics = true,
        diagnostics_open = false,
        git_status = true,
        git_status_open = false,
        git_untracked = true,
        follow_file = true,
        focus = "list",
        auto_close = false,
        jump = { close = false },
        formatters = {
          file = { filename_only = true },
          severity = { pos = "right" },
        },
        matcher = { sort_empty = false, fuzzy = false },
      }
    }
  },
}
