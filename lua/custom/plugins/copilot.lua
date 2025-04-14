return {
	"github/copilot.vim",
	init = function()
		vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
		  expr = true,
		  replace_keycodes = false
		})
		vim.g.copilot_no_tab_map = true
	end

	-- "zbirenbaum/copilot.lua",
}
