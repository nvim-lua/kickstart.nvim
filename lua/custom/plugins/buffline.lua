return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or " ")
						s = s .. n .. sym
					end
					return s
				end,
			},
			--buffline stuff
			vim.keymap.set("n", "<D-'>", "<CMD>BufferLineCycleNext<CR>", { desc = "Next tab" }),
			vim.keymap.set("n", "<D-;>", "<CMD>BufferLineCyclePrev<CR>", { desc = "Prev tab" }),
			vim.keymap.set("n", "<D-k>", "<CMD>bd<CR>", { desc = "[K]ill tab" }),
		})
	end,
}
