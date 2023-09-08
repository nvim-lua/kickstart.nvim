vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 36,
      },
      renderer = {
        group_empty = true,
        icons = {
          glyphs = {
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "➜",
              untracked = "+",
              deleted = "-",
              ignored = "◌",
            },
          }
        }
      },
      -- filters = {
      --   dotfiles = true,
      -- },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Parent'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))

        vim.cmd [[highlight link NvimTreeWinSeparator EndOfBuffer]]
      end,
    })
  end,
  keys = {
    { "<leader>o", "<cmd>:NvimTreeFocus<cr>",    desc = "Focus NvimTree" },
    { "<leader>F", "<cmd>:NvimTreeFindFile<cr>", desc = "Reveal File in NvimTree" }
  },
}
