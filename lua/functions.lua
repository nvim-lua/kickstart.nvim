function InsertTodo()
  vim.api.nvim_put({ '// todo: ' }, 'l', true, true)
end

function InsertId()
  vim.api.nvim_put({ '[Id()]' }, 'l', true, true)
end
