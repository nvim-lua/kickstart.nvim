return {
  'NickvanDyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = function()
    ---@type opencode.Opts
    -- vim.g.opencode_opts = {}

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Keymaps with port injection
    vim.keymap.set({ 'n', 'x' }, '<leader>oq', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode' })

    vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })

    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').prompt '@this'
    end, { desc = 'Add to opencode' })

    vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })

    vim.keymap.set('n', '<leader>oT', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'opencode half page down' })
  end,
}
