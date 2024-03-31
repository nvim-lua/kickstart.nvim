return {
	vim.api.nvim_create_user_command("Notes", function()
		vim.cmd.edit('~/notes/notes.md')
	end, {})
}
