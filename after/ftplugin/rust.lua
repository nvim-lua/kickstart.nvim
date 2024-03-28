local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
	"n",
	"<leader>a",
	function()
		vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
		-- or vim.lsp.buf.codeAction() if you don't want grouping.
	end,
	{ desc = "Rust LSP Code [Action]", silent = true, buffer = bufnr }
)
