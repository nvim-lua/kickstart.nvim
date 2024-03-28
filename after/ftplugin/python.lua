local macchiato_line_length = 80
if (vim.o.textwidth or 0) > 0 then
   macchiato_line_length = vim.o.textwidth
end
vim.opt_local.formatprg = 'black-macchiato -l ' .. macchiato_line_length

vim.keymap.set('n', '<leader>is', function()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })

	if modified then
		print('*** Save your changes first! ***')
		return
	end
	local file_name = vim.api.nvim_buf_get_name(0) -- Get file name of file in current buffer
	vim.cmd(":!isort -l 1000000 --wl 0 --sl " .. file_name)
end, { desc = 'Run isort on the current buffer' })
