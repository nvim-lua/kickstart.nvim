-- local set = vim.opt_local

-- Define a custom command ':intmain' that inserts int main() {} template
vim.api.nvim_create_user_command('IntMain', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = {
    '#include <stdio.h>',
    '',
    'int main ()',
    '{',
    '  ',
    '  printf();',
    '  return 0;',
    '}',
  }
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, lines)
  -- Position cursor inside the function body
  vim.api.nvim_win_set_cursor(0, { current_line + 1, 4 })
end, {})
