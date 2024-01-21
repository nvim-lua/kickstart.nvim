return {
	"iamcco/markdown-preview.nvim",
	config = function()
		vim.fn["mkdp#util#install"]()
		vim.keymap.set("n", "<leader>m", "<CMD>MarkdownPreview<CR>")
		vim.keymap.set("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>")
		vim.g.mkdp_markdown_css = '~/markdown.css'
		vim.g.mkdp_highlight_css = ''

		local mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = 'middle',
			hide_yaml_meta = 1,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = true,
			disable_filename = 1,
			toc = {}
		}

		vim.g.mkdp_preview_options = mkdp_preview_options
	end,
}
