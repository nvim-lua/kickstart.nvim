-- Set up the treesitter nodes for the Python language.
local lang_utils = require("treesj.langs.utils")
local options = {
	join = { space_in_brackets = false },
	split = { last_separator = true },
}

require("treesj").setup(
	{
		use_default_keymaps = false,
		langs = {
			python = {
				argument_list = lang_utils.set_preset_for_args(options),
				assignment = { target_nodes = { "list", "set", "tuple", "dictionary" } },
				call = { target_nodes = { "argument_list" } },
				dictionary = lang_utils.set_preset_for_dict(options),
				list = lang_utils.set_preset_for_list(options),
				parameters = lang_utils.set_preset_for_args(options),
				set = lang_utils.set_preset_for_list(options),
				tuple = lang_utils.set_preset_for_list(options),
			}
		}
	}
)
