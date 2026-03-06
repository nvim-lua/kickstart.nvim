return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals' },
  },
  keys = {
    {
      '<leader>wr',
      function()
        require('persistence').load()
      end,
      desc = '[W]orkspace [R]estore session',
    },
    {
      '<leader>wl',
      function()
        require('persistence').load { last = true }
      end,
      desc = '[W]orkspace [L]ast session',
    },
    {
      '<leader>wd',
      function()
        require('persistence').stop()
      end,
      desc = '[W]orkspace [D]isable session save',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('persistence-auto-restore', { clear = true }),
      callback = function()
        if vim.fn.argc(-1) > 0 then
          return
        end

        local ignored = { gitcommit = true, gitrebase = true }
        if ignored[vim.bo.filetype] then
          return
        end

        require('persistence').load()
      end,
      nested = true,
    })
  end,
}
