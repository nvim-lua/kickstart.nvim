local powershell_options = {
  -- shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell',
  -- shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[',
  -- shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
  -- shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
  -- shellquote = '',
  -- shellxquote = '',
  shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell',
  shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
  shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
  shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
  shellquote = '',
  shellxquote = '',
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end

return {}
