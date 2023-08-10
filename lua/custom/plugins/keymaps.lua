return {
  -- local function map(mode, lhs, rhs, opts)
  --   local options = { noremap=true, silent=true }
  --   if opts then
  --     options = vim.tbl_extend('force', options, opts)
  --   end
  --   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  -- end

  vim.keymap.set('n', '<leader>ff', ":Telescope find_files<cr>", {}),
  vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<cr>", {}),
  vim.keymap.set('n', '<leader>fb', ":Telescope buffers<cr>", {}),
  vim.keymap.set('n', '<leader>fh', ":Telescope help_tags", {}),

  -- map("n", "<s-h>", ":bn")
  vim.keymap.set(
    'n',
    '<S-h>',
    ":bp<cr>",
    {
      buffer = bufnr,
      desc = '[G]o to [P]revious Buffer'
    }
  ),
  -- map("n", "<s-l>", ":bp")
  vim.keymap.set(
    'n',
    '<S-l>',
    ":bn<cr>",
    {
      buffer = bufnr,
      desc = '[G]o to [N]ext Buffer'
    }
  )

  -- map("n", "<leader>bq", ":Bdelete")
  -- vim.keymap.set(
  --   'n',
  --   '<leader>bq',
  --   vim.cmd("bdelete"),
  --   {
  --     buffer = bufnr,
  --     desc = '[G]o to [D]elete Buffer'
  --   }
  -- ),
  -- map("n", "<leader>bd", ":bd")
  -- vim.keymap.set(
  --   'n',
  --   '<leader>bd',
  --   vim.cmd("bd"),
  --   {
  --     buffer = bufnr,
  --     desc = '[G]o to [D]elete Buffer'
  --   }
  -- ),

  -- map("n", "<leader>bu", ":bufdo :Bdelete")
  -- vim.keymap.set(
  --   'n',
  --   '<leader>bu',
  --   vim.cmd("bufdo :bdelete"),
  --   {
  --     buffer = bufnr,
  --     desc = '[G]o to [D]elete Buffer'
  --   }
  -- ),

  -- -- map("n", "<leader>bo", "func("buf_only_window_only")
  -- vim.keymap.set(
  --   'n',
  --   '<leader>bo',
  --   vim.call("buf_only_window_only"),
  --   {
  --     buffer = bufnr,
  --     desc = '[G]o to [D]elete Buffer'
  --   }
  -- ),

  -- map("n", "<leader>be", ":new")
  -- vim.keymap.set(
  --   'n',
  --   '<leader>be',
  --   vim.cmd("new"),
  --   {
  --     buffer = bufnr,
  --     desc = '[G]o to [D]elete Buffer'
  --   }
  -- )

  -- -- map("n", "<bs>", func("load_previous_buffer"))
  -- vim.keymap.set(
  --   'n',
  --   '<leader>be',
  --   vim.cmd("load_previous_buffer"),
  --   {
  --     buffer = bufnr,
  --     desc = '[G]o to [D]elete Buffer'
  --   }
  -- )
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
