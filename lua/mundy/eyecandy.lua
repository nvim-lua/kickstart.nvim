vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

function LineNumberColors()
	vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='grey', bold=false }) -- '#F0DBAF'
	vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
	vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='grey', bold=false })
end
