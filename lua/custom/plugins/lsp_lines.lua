return {
  "ErichDonGubler/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()

    -- Disable default virtual text to prevent overlapping/duplicate diagnostic lines
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
  -- Keymap to toggle lsp_lines
  keys = {
    {
      "<leader>ll",
      function()
        require("lsp_lines").toggle()
      end,
      desc = "Toggle lsp_lines",
    },
  },
}
