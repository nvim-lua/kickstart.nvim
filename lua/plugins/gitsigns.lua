local plugin = {"lewis6991/gitsigns.nvim"}
plugin.opts = {
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" }
	}
}
return plugin

