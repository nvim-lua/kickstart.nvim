return {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()

			vim.keymap.set("n", "<leader>m", "<CMD>MarkdownPreview<CR>")
			vim.keymap.set("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>")
    end,
}
