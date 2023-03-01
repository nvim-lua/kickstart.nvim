return {
	"ggandor/leap.nvim",
	config = function()
		require('leap').add_default_mappings()
		vim.keymap.set('n', 's', function()
			local current_window = vim.fn.win_getid()
			require('leap').leap { target_windows = { current_window } }
		end)
	end
}
