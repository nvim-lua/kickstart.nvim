vim.cmd [[:command! -nargs=1 I lua inspectFn(<f-args>)]]
function inspectFn(obj)
  local cmd = string.format('lua print(vim.inspect(%s))', obj)
  require('noice').redirect(cmd, { view = 'messages', filter = {} })
end
