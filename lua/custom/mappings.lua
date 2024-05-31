local utils = require 'custom.utils'

vim.keymap.set('n', '<leader>yn', function()
  local filename = vim.fn.expand '%:t'
  vim.fn.setreg('+', filename)
end, { desc = '[Y]ank file [N]ame' })

vim.keymap.set('n', '<leader>yp', function()
  local filepath = vim.fn.expand '%:p'
  vim.fn.setreg('+', filepath)
end, { desc = '[Y]ank file [P]ame' })

vim.keymap.set('n', '<leader>ys', function()
  local filepath = vim.fn.expand '%:p'
  local filename = vim.fn.expand '%:t'
  local modify = vim.fn.fnamemodify

  local vals = {
    ['BASENAME'] = modify(filename, ':r'),
    ['EXTENSION'] = modify(filename, ':e'),
    ['FILENAME'] = filename,
    ['PATH (CWD)'] = modify(filepath, ':.'),
    ['PATH (HOME)'] = modify(filepath, ':~'),
    ['PATH'] = filepath,
    ['URI'] = vim.uri_from_fname(filepath),
  }

  local options = vim.tbl_filter(function(val)
    return vals[val] ~= ''
  end, vim.tbl_keys(vals))
  if vim.tbl_isempty(options) then
    utils.notify('No values to copy', vim.log.levels.WARN)
    return
  end
  table.sort(options)
  vim.ui.select(options, {
    prompt = 'Choose to copy to clipboard:',
    format_item = function(item)
      return ('%s: %s'):format(item, vals[item])
    end,
  }, function(choice)
    local result = vals[choice]
    if result then
      utils.notify(('Copied: `%s`'):format(result))
      vim.fn.setreg('+', result)
    end
  end)
end, { desc = '[Y]ank [S]elector' })
