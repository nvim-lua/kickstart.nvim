vim.cmd([[
		augroup FormatAutogroup
		autocmd!
		autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs,*.cts,*.mts Prettier
		augroup END
]])
