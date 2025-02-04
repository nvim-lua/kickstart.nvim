vim.api.nvim_command 'hi clear'
if vim.fn.exists 'syntax_on' then
  vim.api.nvim_command 'syntax reset'
end

vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi
vim.o.termguicolors = true
vim.g.colors_name = 'koa'

-- colors.generate(config.mirage)
-- if config.terminal then
-- set_terminal_colors()
-- end
-- set_groups()

vim.g.terminal_color_0 = '#000000'
vim.g.terminal_color_background = '#000000'

vim.api.nvim_set_hl(0, 'Normal', { fg = '#FFFFFF', bg = '#000000' })
