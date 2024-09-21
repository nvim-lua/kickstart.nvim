vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag =
  "-NoProfile -NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

vim.api.nvim_create_user_command('Pterm', 'term pwsh', {})
vim.api.nvim_create_user_command('PT', 'term pwsh', {})
vim.api.nvim_create_user_command('Uterm', 'term wsl.exe', {})
vim.api.nvim_create_user_command('UT', 'term wsl.exe', {})
vim.api.nvim_create_user_command('BDAll', '%bd! | e#', {})
vim.api.nvim_create_user_command('NT', 'bd! % | term', {})
vim.api.nvim_create_user_command('NUT', 'bd! % | Uterm', {})
vim.api.nvim_create_user_command('CC', 'CopilotChat', {})

return {}
