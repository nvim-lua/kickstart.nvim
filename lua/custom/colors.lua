local colors = {}
function colors.LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#999966', bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#999966', bold=true })
end

vim.api.nvim_create_user_command('TransparencyToggle',
  function (opts)
    vim.cmd('TransparentToggle')
    colors.LineNumberColors()
  end,
  {}
)

vim.g.transparent_groups = vim.list_extend(
  vim.g.transparent_groups or {},
  vim.tbl_map(function(v)
    return v.hl_group
  end, vim.tbl_values(require('bufferline.config').highlights))
)

return colors
