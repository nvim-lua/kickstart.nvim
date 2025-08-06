-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>w', '<cmd>:w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>pv', '<cmd>:Ex<CR>', { desc = 'Go back to Dir' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Auto-close brackets
vim.keymap.set('i', '(', '()<Left>')
vim.keymap.set('i', '[', '[]<Left>')
vim.keymap.set('i', '{', '{}<Left>')
vim.keymap.set('i', '"', '""<Left>')
vim.keymap.set('i', "'", "''<Left>")

-- Smart enter for brackets
vim.keymap.set('i', '<CR>', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before = line:sub(col, col)
  local after = line:sub(col + 1, col + 1)
  
  if (before == '{' and after == '}') or 
     (before == '[' and after == ']') or 
     (before == '(' and after == ')') then
    return '<CR><CR><Up><Tab>'
  else
    return '<CR>'
  end
end, { expr = true })

-- Move lines up/down with Alt+J/K
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Comment/uncomment lines with Ctrl+,
vim.keymap.set('n', '<C-,>', 'gcc', { desc = 'Comment line', remap = true })
vim.keymap.set('v', '<C-,>', 'gc', { desc = 'Comment selection', remap = true })

vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to clipboard' })

-- New file and directory creation
vim.keymap.set('n', '<leader>nf', function()
  local current_dir = vim.fn.expand('%:p:h')
  if current_dir == '' then
    current_dir = vim.fn.getcwd()
  end
  
  vim.ui.input({
    prompt = 'New file name: ',
    default = current_dir .. '/',
    completion = 'file',
  }, function(input)
    if input then
      local file_path = input
      -- If it's not an absolute path, make it relative to current file's directory
      if not vim.startswith(file_path, '/') then
        file_path = current_dir .. '/' .. file_path
      end
      
      -- Create parent directories if they don't exist
      local parent_dir = vim.fn.fnamemodify(file_path, ':h')
      vim.fn.mkdir(parent_dir, 'p')
      
      -- Create and open the file
      vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    end
  end)
end, { desc = 'New File' })

vim.keymap.set('n', '<leader>nd', function()
  local current_dir = vim.fn.expand('%:p:h')
  if current_dir == '' then
    current_dir = vim.fn.getcwd()
  end
  
  vim.ui.input({
    prompt = 'New directory name: ',
    default = current_dir .. '/',
    completion = 'dir',
  }, function(input)
    if input then
      local dir_path = input
      -- If it's not an absolute path, make it relative to current file's directory
      if not vim.startswith(dir_path, '/') then
        dir_path = current_dir .. '/' .. dir_path
      end
      
      -- Create the directory
      local success = vim.fn.mkdir(dir_path, 'p')
      if success == 1 then
        print('Created directory: ' .. dir_path)
      else
        print('Failed to create directory: ' .. dir_path)
      end
    end
  end)
end, { desc = 'New Directory' })