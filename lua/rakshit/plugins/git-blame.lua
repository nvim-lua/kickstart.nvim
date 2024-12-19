return {
  "f-person/git-blame.nvim",
  -- load the plugin at startup
  event = "VeryLazy",
  -- Because of the keys part, you will be lazy loading this plugin.
  -- The plugin wil only load once one of the keys is used.
  -- If you want to load the plugin at startup, add something like event = "VeryLazy",
  -- or lazy = false. One of both options will work.
  opts = function()
    local hl_cursor_line = vim.api.nvim_get_hl(0, { name = "CursorLine" })
    local hl_question = vim.api.nvim_get_hl(0, { name = "Question" })
    local hl_combined = vim.tbl_extend("force", hl_question, { bg = hl_cursor_line.bg })
    vim.api.nvim_set_hl(0, "CursorLineBlame", hl_combined)
    return {
      enabled = true,
      highlight_group = "CursorLineBlame",
      message_template = " <author> • <date> • <summary> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%b-%d-%Y", -- template for the date, check Date format section for more options
      virtual_text_column = 80, -- virtual text start column, check Start virtual text at column section for more options
      message_when_not_committed = "Not committed yet",
      display_virtual_text = 1,
      -- highlight_group = "Question",
    }
  end,
}
