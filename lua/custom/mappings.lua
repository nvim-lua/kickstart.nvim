local utils = require 'custom.utils'

vim.keymap.set('n', '<leader>yn', function()
  local filename = vim.fn.expand '%:t'
  vim.fn.setreg('+', filename)
end, { desc = '[Y]ank file [N]ame' })

vim.keymap.set('n', '<leader>yp', function()
  local filepath = vim.fn.expand '%:p'
  vim.fn.setreg('+', filepath)
end, { desc = '[Y]ank file [P]ath' })

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

-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- https://youtu.be/w7i4amO_zaE?si=bRJDSVlL_vvFwmxh
-- move visually selected block upward or downward
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- hold cursor in place while joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- hold cursor in the middle while scrolling half of a page
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- hold cursor in the middle while navigation throgh search
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = '[P]aste and keep the copy buffer' })
vim.keymap.set('n', '<leader>rc', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]ename [C]urrent word' })
-- end Primeagen

vim.keymap.set('n', '<leader>n', '<cmd>enew<cr>', { desc = '[N]ew File' })
vim.keymap.set('n', '<leader>Q', '<cmd>qall<cr>', { desc = '[Q]uit all' })

-- Stay in indent mode
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Unindent line' })
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent line' })

vim.keymap.set('n', '<leader>A', 'ggVG%', { desc = 'Select [A]ll' })
