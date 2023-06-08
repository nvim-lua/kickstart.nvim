-- NVIM tree
-- a file explore plugin

local function on_nvim_tree_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	-- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
	-- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
	vim.keymap.set('n', '<C-b>', api.tree.toggle, opts('Toggle tree'))
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	--
	-- after = "nvim-web-devicons",
	-- requires = "nvim-tree/nvim-web-devicons",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			update_cwd = true,
			update_focused_file = {
				enable = true
			},
			respect_buf_cwd = true,
			on_attach = on_nvim_tree_attach,
		}
	end,
}
