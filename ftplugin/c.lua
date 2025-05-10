-- Import vim module
local set = vim.opt_local

set.shiftwidth = 4
set.tabstop = 4
set.commentstring = '/* %s */'

-- Define a custom command ':IntMain' that inserts int main() {} template
vim.api.nvim_create_user_command('IntMain', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = {
    '#include <stdio.h>',
    '',
    'int main ()',
    '{',
    '    ',
    '    printf();',
    '    return 0;',
    '}',
  }
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, lines)
  -- Position cursor inside the function body
  vim.api.nvim_win_set_cursor(0, { current_line + 1, 4 })
end, {})

vim.api.nvim_create_user_command('Libft', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, {
    '#include "libft.h"',
  })
end, {})

vim.api.nvim_create_user_command('CommentRestOfFile', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local last_line = vim.api.nvim_buf_line_count(0)

  -- Get all lines from current to end of file
  local lines = vim.api.nvim_buf_get_lines(0, current_line - 1, last_line, false)

  -- Prefix each line with //
  for i = 1, #lines do
    lines[i] = '//' .. lines[i]
  end

  -- Set the modified lines back in the buffer
  vim.api.nvim_buf_set_lines(0, current_line - 1, last_line, false, lines)
end, {})

vim.api.nvim_create_user_command('UncommentRestOfFile', function ()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local last_line = vim.api.nvim_buf_line_count(0)

  -- Get all lines from current to end of file
  local lines = vim.api.nvim_buf_get_lines(0, current_line - 1, last_line, false)

  -- Remove leading // if present
  for i = 1, #lines do
    lines[i] = lines[i]:gsub("^%s*//", "")
  end

  -- Set the modified lines back in the buffer
  vim.api.nvim_buf_set_lines(0, current_line - 1, last_line, false, lines)
end, {})
