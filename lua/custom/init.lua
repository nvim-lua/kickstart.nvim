vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>n', ':Neotree<CR>', { noremap = true, silent = true, desc = 'Open [N]eotree Explorer' })

vim.keymap.set('n', '<C-s>', function()
  vim.lsp.buf.format()
  vim.cmd.w()
end, { desc = '[S]ave file' })

vim.keymap.set('i', '<C-s>', function()
  vim.lsp.buf.format()
  vim.cmd.w()
end, { desc = '[S]ave file' })


vim.api.nvim_create_autocmd('VimEnter', {
    desc = 'Auto select virtualenv Nvim open',
    pattern = '*',
    callback = function()
      local venv = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
      if venv ~= '' then
        require('venv-selector').retrieve_from_cache()
      end
    end,
    once = true,
  })
