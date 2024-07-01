local plugin = {"nvim-treesitter/nvim-treesitter"}
plugin.build = ":TsUpdate"
plugin.opts = {
	ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "rust", "go", "css" },
	auto_install = true,
	hightlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby", "html" }},
}
plugin.config = function(_, opts)
	require("nvim-treesitter.install").prefer_git = true
	require("nvim-treesitter.configs").setup(opts)
end
return plugin

