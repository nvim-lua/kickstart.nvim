-- if does not work, go manually in the folder .local/share/nvim/site/pack/packer/start/markdown-preview.nvim/app and run yarn install

return {
	"iamcco/markdown-preview.nvim",
	run = "cd app && yarn install",
	setup = function()
		vim.g.mkdp_filetypes = {
			"markdown" }
	end,
	ft = { "markdown" }
}
