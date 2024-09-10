-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"lawrence-laz/neotest-zig",
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					-- Registration
					require("neotest-zig")({
						dap = {
							adapter = "lldb",
						},
					}),
				},
				log_level = vim.log.levels.TRACE,
			})

			vim.keymap.set("n", "<leader>tts", neotest.summary.toggle, { desc = "[T]oggle [T]est [S]ummary" })
			vim.keymap.set("n", "<leader>top", neotest.output_panel.toggle, { desc = "[T]oggle [O]utput [P]annel" })
			vim.keymap.set("n", "<leader>rnt", neotest.run.run, { desc = "[R]un [N]earest [T]est" })
			vim.keymap.set("n", "<leader>ostr", function()
				neotest.output.open({ enter = true, short = true, auto_close = true })
			end, { desc = "[O]pen [S]hort [T]est [R]esult" })

			vim.keymap.set("n", "<leader>otr", function()
				neotest.output.open({ enter = true, short = false, auto_close = true })
			end, { desc = "[O]pen [T]est [R]esult" })
			vim.keymap.set("n", "<leader>rft", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "[R]un [F]ile [T]ests" })
		end,
	},
}
