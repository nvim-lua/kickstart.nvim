return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  -- to open oil with - as shortcut
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
  opts = {},
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}

-- return {
--   {
-- 'stevearc/oil.nvim',
-- vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     config = function()
--       CustomOilBar = function()
--         local path = vim.fn.expand "%"
--         path = path:gsub("oil://", "")
--
--         return "  " .. vim.fn.fnamemodify(path, ":.")
--       end
--
--       require("oil").setup {
--         columns = { "icon" },
--         keymaps = {
--           ["<C-h>"] = false,
--           ["<C-l>"] = false,
--           ["<C-k>"] = false,
--           ["<C-j>"] = false,
--           ["<M-h>"] = "actions.select_split",
--         },
--         win_options = {
--           winbar = "%{v:lua.CustomOilBar()}",
--         },
--         view_options = {
--           show_hidden = true,
--           is_always_hidden = function(name, _)
--             local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
--             return vim.tbl_contains(folder_skip, name)
--           end,
--         },
--       }
--
--       -- Open parent directory in current window
--       vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
--
--       -- Open parent directory in floating window
--       vim.keymap.set("n", "<space>-", require("oil").toggle_float)
--     end,
--   },
-- }
