-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   branch = "v3.x",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--     "MunifTanjim/nui.nvim",
--   },
--   opts = {
--     window = {
--       position = "left",
--       width = 40,
--       mapping_options = {
--         noremap = true,
--         nowait = true,
--       },
--     },
--     filesystem = {
--       filtered_items = {
--         visible = false, -- when true, they will just be displayed differently than normal items
--         hide_dotfiles = false,
--         hide_gitignored = true,
--         hide_hidden = true, -- only works on Windows for hidden files/directories
--         hide_by_name = {
--           "node_modules"
--         },
--         hide_by_pattern = { -- uses glob style patterns
--           --"*.meta",
--           --"*/src/*/tsconfig.json",
--         },
--         always_show = { -- remains visible even if other settings would normally hide it
--           --".gitignored",
--         },
--         never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
--           --".DS_Store",
--           --"thumbs.db"
--         },
--         never_show_by_pattern = { -- uses glob style patterns
--           --".null-ls_*",
--         },
--       },
--       follow_current_file = {
--         enabled = false,                      -- This will find and focus the file in the active buffer every time
--         --               -- the current file is changed while the tree is open.
--         leave_dirs_open = false,              -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
--       },
--       group_empty_dirs = false,               -- when true, empty folders will be grouped together
--       hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
--     },
--   },
--   config = function()
--     require("neo-tree").setup()
--     vim.keymap.set("n", "<leader>T", "<Cmd>Neotree toggle current reveal_force_cwd<CR>")
--     vim.keymap.set("n", "<leader>|", "<Cmd>Neotree reveal<CR>")
--     vim.keymap.set("n", "gd", "<Cmd>:Neotree float reveal_file=<cfile> reveal_force_cwd<CR>")
--     vim.keymap.set("n", "<leader>Br", "<Cmd>:Neotree toggle show buffers right<CR>")
--     vim.keymap.set("n", "<leader>Gs", "<Cmd>:Neotree float git_status<CR>")
--   end
-- }
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {}
  end,
}
