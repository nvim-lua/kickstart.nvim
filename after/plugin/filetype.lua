local function set_filetype(pattern, filetype)
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = pattern,
    command = 'set filetype=' .. filetype,
  })
end

set_filetype('.swcrc', 'json')
set_filetype('.prettierrc', 'json')
set_filetype('docker-compose.yml', 'yaml.docker-compose')
