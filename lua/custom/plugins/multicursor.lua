return {
	'mg979/vim-visual-multi',
	event = "BufReadPre",
	init = function()
		vim.g.VM_maps = {
			["Find Under"] = "<M-n>",
			-- ["Select Next"] = "<C-n>",
			-- ["Select Prev"] = "<C-p>",
			-- ["Add Cursor Down"] = "<C-j>",
			-- ["Add Cursor Up"] = "<C-k>",
			-- ["Add Cursor to Next"] = "<C-n>",
			-- ["Add Cursor to Prev"] = "<C-p
		}
	end
}
