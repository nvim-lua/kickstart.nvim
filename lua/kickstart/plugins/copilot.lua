return {
  {
    "github/copilot.vim",
    -- disable copilot by default
    lazy = true,
    keys = { "<leader>ce" },
    config = function()
    vim.cmd("Copilot")
        vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false,
        })
        vim.keymap.set("n", "<leader>cd", ":Copilot disable <CR>", {})
        vim.keymap.set("n", "<leader>ce", ":Copilot enable <CR>", {})
    end,
  }
}
