-- for tablines

return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('bufferline').setup {
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				}
			},
		}
	end,
}
