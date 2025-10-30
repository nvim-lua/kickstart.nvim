return {
  'ojroques/nvim-osc52',
  event = 'VeryLazy',
  opts = { max_length = 0, silent = true },
  config = function(_, opts)
    require('osc52').setup(opts)

    -- Send *any* yank to the local clipboard automatically
    vim.api.nvim_create_autocmd('TextYankPost', {
      callback = function()
        if vim.v.event.operator == 'y' then
          require('osc52').copy_register(vim.v.event.regname == '' and '"' or vim.v.event.regname)
        end
      end,
    })

    -- Optional: explicit mappings
    vim.keymap.set({ 'n', 'x' }, '<leader>y', require('osc52').copy_visual, { desc = 'Yank→local clipboard' })
  end,
}
