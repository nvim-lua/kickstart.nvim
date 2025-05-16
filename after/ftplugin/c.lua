-- Import vim module
local set = vim.opt_local

-- Indentation settings
set.expandtab = true     -- Convert tabs to spaces
set.shiftwidth = 4       -- Indent size for autoindent
set.tabstop = 4          -- How wide tabs appear
set.softtabstop = 4      -- How many spaces Tab key inserts/removes

-- Comment string for commentary plugins
set.commentstring = '/* %s */'

-- Disable vim-sleuth for C files
vim.g.sleuth_automatic = 0

-- Define a custom command ':IntMain' that inserts int main() {} template
vim.api.nvim_create_user_command('IntMain', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = {
    '#include <stdio.h>',
    '',
    'int main(void)',
    '{',
    '    ',
    '    printf("Hello, world!\\n");',
    '    return 0;',
    '}',
  }
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, lines)
  -- Position cursor inside the function body
  vim.api.nvim_win_set_cursor(0, { current_line + 4, 4 })
end, {})

-- Define a custom command ':Libft' that inserts libft.h include
vim.api.nvim_create_user_command('Libft', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, {
    '#include "libft.h"',
  })
end, {})

-- Define a custom command ':CommentRestOfFile' that comments out rest of file
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

-- Define a custom command ':UncommentRestOfFile' that removes comments from rest of file
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

-- -- Debugging command to check indentation settings
-- vim.api.nvim_create_user_command('CheckIndent', function()
--   print("expandtab: " .. tostring(vim.bo.expandtab))
--   print("tabstop: " .. vim.bo.tabstop)
--   print("shiftwidth: " .. vim.bo.shiftwidth)
--   print("softtabstop: " .. vim.bo.softtabstop)
-- end, {})

-- Force settings to apply after all other scripts have loaded
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.c,*.h",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end
})

-- Add any C-specific key mappings you want here
-- Example: Map F5 to compile and run the current file
vim.keymap.set('n', '<F5>', function()
  local filename = vim.fn.expand('%:r')
  vim.cmd('write')
  vim.cmd('belowright split | terminal gcc -Wall -Wextra -Werror % -o ' .. filename .. ' && ./' .. filename)
end, { buffer = true, desc = 'Compile and run C file' })
