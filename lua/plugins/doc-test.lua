---@diagnostic disable: undefined-global
-- Test doc window plugin
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Create a test function that shows a styled floating window
    local function test_doc_window()
      local contents = {
        "## Documentation Test",
        "",
        "This is a test documentation window to see how styling works.",
        "",
        "**Important**: This shows what documentation *should* look like.",
        "",
        "```lua",
        "function example(param)",
        "  -- This is a code sample",
        "  return param + 1",
        "end",
        "```",
      }
      
      -- Create a nicely styled window
      local opts = {
        border = "rounded",
        width = 60,
        height = 12,
        wrap = true,
        pad_left = 1,
        pad_right = 1,
      }
      
      local bufnr = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
      vim.api.nvim_buf_set_option(bufnr, "filetype", "markdown")
      
      -- Position the window near the cursor
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      local row = cursor_pos[1]
      local col = cursor_pos[2]
      
      -- Calculate position
      local ui = vim.api.nvim_list_uis()[1]
      local width = opts.width or 60
      local height = opts.height or 12
      local anchor = "NW"
      local col_offset = 0
      
      -- Open the window
      local winnr = vim.api.nvim_open_win(bufnr, false, {
        relative = "cursor",
        row = 1,
        col = col_offset,
        width = width,
        height = height,
        style = "minimal",
        border = opts.border,
        anchor = anchor,
      })
      
      -- Set window options
      vim.api.nvim_win_set_option(winnr, "conceallevel", 2)
      vim.api.nvim_win_set_option(winnr, "concealcursor", "n")
      vim.api.nvim_win_set_option(winnr, "winblend", 0)
      
      -- Return window and buffer numbers
      return bufnr, winnr
    end
    
    -- Add a command to test the documentation window
    vim.api.nvim_create_user_command("TestDocWindow", test_doc_window, {})
    
    -- Also map it to a key for easy testing
    vim.keymap.set("n", "<leader>td", test_doc_window, { desc = "Test doc window styling" })
  end
}
