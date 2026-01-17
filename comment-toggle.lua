-- Function to detect if a line contains JSX/TSX content
local function is_jsx_line(line)
  -- Check for JSX patterns: <tag, </tag, self-closing <tag />, or JSX expressions
  return line:match('<[/%a]') ~= nil
    or line:match('/>%s*$') ~= nil
    or line:match('^%s*{') ~= nil  -- Lines starting with { (JSX expressions)
end

-- Function to comment out line(s)
local function comment_line()
  local count = vim.v.count + 1
  local start_line = vim.fn.line '.' -- Get current line number
  local filetype = vim.bo.filetype

  -- Check only the first line to determine comment style for all lines
  local first_line = vim.fn.getline(start_line)

  -- Detect if it's a JSX comment or regular comment on first line
  local is_jsx_commented = first_line:match '^%s*{/%*' ~= nil
  local is_regular_commented = first_line:match '^%s*//' ~= nil

  -- Determine comment style to use based on first line
  local use_jsx_comment = false
  if not is_jsx_commented and not is_regular_commented then
    -- When commenting: check if first line is JSX content
    use_jsx_comment = (filetype == 'typescriptreact' or filetype == 'javascriptreact') and is_jsx_line(first_line)
  end

  for i = 0, count - 1 do
    local line_num = start_line + i
    local line = vim.fn.getline(line_num)
    local new_line

    if is_jsx_commented then
      -- Uncomment JSX: remove {/* and */}
      new_line = line:gsub('^(%s*){/%*%s*(.-)%s*%*/}', '%1%2')
    elseif is_regular_commented then
      -- Uncomment: remove leading whitespace, //, and optional space after //
      new_line = line:gsub('^%s*//%s?', '')
    else
      -- Comment: use style determined from first line
      if use_jsx_comment then
        -- JSX comment: {/* ... */}
        new_line = line:gsub('^(%s*)(.*)', '%1{/* %2 */}')
      else
        -- Regular comment: //
        new_line = '// ' .. line
      end
    end

    vim.fn.setline(line_num, new_line)
  end

  -- Move cursor down by count lines
  vim.cmd('normal! ' .. count .. 'j')
end

vim.keymap.set('n', '<leader>c', comment_line, { desc = 'Toggle line comment(s)' })
