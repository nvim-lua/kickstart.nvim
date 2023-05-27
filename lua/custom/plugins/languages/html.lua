function FormatHTML()
  -- Check if the current file type is HTML
  if vim.bo.filetype == 'html' then
    vim.cmd [[s/<[^>]*>/\r&\r/g]]
    vim.cmd [[g/^$/d]]
    vim.cmd [[normal gg=G]]
  else
    print 'This command is applicable only for HTML files.'
  end
end

-- Mapping as a command
vim.cmd [[command! FormatHTML lua FormatHTML()]]

-- Mapping as a shortcut
vim.api.nvim_set_keymap('n', '<Leader>p', ':lua FormatHTML()<CR>', { silent = true })

return {}
