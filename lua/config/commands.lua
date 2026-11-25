-- :'<,'>Comment [prefix] / :'<,'>Uncomment [prefix] -- prepend/remove a comment prefix (default `#`) on the selected lines
local function parse_prefix(opts)
  return opts.args ~= '' and opts.args or '#'
end

vim.api.nvim_create_user_command('Comment', function(opts)
  local prefix = parse_prefix(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  for i, line in ipairs(lines) do
    lines[i] = prefix .. line
  end
  vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, lines)
end, { range = true, nargs = '?', desc = 'Prefix the selected lines with a comment marker (default #)' })

vim.api.nvim_create_user_command('Uncomment', function(opts)
  local prefix = parse_prefix(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  for i, line in ipairs(lines) do
    if vim.startswith(line, prefix) then
      lines[i] = line:sub(#prefix + 1)
    end
  end
  vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, lines)
end, { range = true, nargs = '?', desc = 'Remove the comment marker (default #) from the start of the selected lines' })

-- Allow typing the lowercase form: :'<,'>comment # / :'<,'>uncomment #
local function expand_lowercase(name)
  local line = vim.fn.getcmdline()
  if vim.fn.getcmdtype() == ':' and line:match('^[%d,%.%$%%\'<>]*%s*' .. name .. '$') then
    return name:sub(1, 1):upper() .. name:sub(2)
  end
  return name
end

local M = {}
for _, name in ipairs { 'comment', 'uncomment' } do
  M[name] = function()
    return expand_lowercase(name)
  end
  vim.cmd(("cnoreabbrev <expr> %s v:lua.require'config.commands'.%s()"):format(name, name))
end

return M
