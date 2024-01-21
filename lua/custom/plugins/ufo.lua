-- install plugin for code folding

return {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
	-- default settings to enable
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

	-- setup folding source: first lsp, then indent as fallback
        require("ufo").setup({
		provider_selector = function(bufnr, filetype, buftype)
			return { 'lsp', 'indent' }
		end
	})

	-- remap keys for "fold all" and "unfold all"
	vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
	vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })
    end,
}

