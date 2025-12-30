-- You can add your own custom.plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	unpack(require("custom.plugins.debug")),
	unpack(require("custom.plugins.autopairs")),
	unpack(require("custom.plugins.nvim-ufo")),
	unpack(require("custom.plugins.blink")),
	unpack(require("custom.plugins.independent-plugins")),
	unpack(require("custom.plugins.todo")),
	unpack(require("custom.plugins.guess-indent")),
	unpack(require("custom.plugins.color-schemes")),
	unpack(require("custom.plugins.tree_sitter")),
	unpack(require("custom.plugins.telescope")),
	unpack(require("custom.plugins.indent_line")),
	unpack(require("custom.plugins.lint")),
	unpack(require("custom.plugins.gitsigns")),
	unpack(require("custom.plugins.which-key")),
}
