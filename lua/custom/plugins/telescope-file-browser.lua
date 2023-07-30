local tfb = require("telescope")

vim.api.nvim_set_keymap(
	"n",
	"<space>fb",
	":Telescope file_browser<CR>",
	{ noremap = true }
)

return { tfb.setup(),
	tfb.load_extension "file_browser",

}
