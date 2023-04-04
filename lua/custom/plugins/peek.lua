return {
	"toppair/peek.nvim",
    ft = "markdown",
	build = "deno task --quiet build:fast",
	init = function()
		require("peek").setup({
			auto_load = true,
			close_on_bdelete = true,
			syntax = false,
			theme = "light",
			update_on_change = true,
            app = 'webview',
            filetype = {"markdown"},
			throttle_at = 200000,
			throttle_time = "auto",
		})

        require("peek_settings.commands")
	end,
}
