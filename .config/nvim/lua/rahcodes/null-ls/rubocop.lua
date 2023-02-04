local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
	name = "rubocop",
	meta = {
		url = "https://github.com/rubocop/rubocop",
		description = "Ruby static code analyzer and formatter, based on the community Ruby style guide.",
	},
	method = FORMATTING,
	filetypes = { "ruby" },
	generator_opts = {
		command = "rubocop",
		args = {
			"--auto-correct",
			"-f",
			"quiet",
			"--stdin",
			"$FILENAME",
		},
		to_stdin = true,
		--		from_stderr = true,
	},
	factory = h.formatter_factory,
})
