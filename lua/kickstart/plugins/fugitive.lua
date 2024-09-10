return {
  'tpope/vim-fugitive',

  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'fugitive Git' })

    local mimivalsi_fugitive = vim.api.nvim_create_augroup('mimivalsi_fugitive', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = mimivalsi_fugitive,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set('n', '<leader>p', function()
          vim.cmd.Git 'push'
        end, { desc = 'Git push' })

        vim.keymap.set('n', '<leader>P', function()
          vim.cmd.Git { 'pull', '--rebase' }
        end, opts)

        vim.keymap.set('n', '<leader>o', ':Git push -u origin', opts)
      end,
    })

    -- vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>')
    -- vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>')
  end,
}
