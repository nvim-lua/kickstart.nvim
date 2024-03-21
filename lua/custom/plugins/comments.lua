return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({})

    -- Keymaps
    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })

    vim.api.nvim_set_keymap(
      "n",
      "<leader>st",
      ":TodoTelescope<CR>",
      { noremap = true, desc = "[S]earch [T]odos" }
    )
  end
}
