local set = vim.opt_local

<<<<<<< Updated upstream
set.shiftwidth = 4
set.tabstop = 4
vim.g.sleuth_automatic = 0
=======
-- Use tabs instead of spaces
set.expandtab = false  -- Use real tabs, not spaces
set.shiftwidth = 4     -- Size of an indent
set.tabstop = 4        -- Size of a tab
set.softtabstop = 0    -- Disable softtabstop
>>>>>>> Stashed changes
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
  
  -- Force these settings after any other scripts might have changed them
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = true
    end
  })