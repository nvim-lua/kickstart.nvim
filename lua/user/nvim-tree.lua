local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent,        opts("Up"))
  vim.keymap.set("n", "?",     api.tree.toggle_help,                  opts("Help"))
  vim.keymap.set("n", "l",     api.node.open.edit,                    opts("Open"))
  vim.keymap.set("n", "h",     api.node.navigate.parent_close,        opts("close_node"))
end


-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
nvim_tree.setup({
  on_attach = my_on_attach,
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
  },
  hijack_cursor = true,
  renderer = {
      highlight_git = true,
      root_folder_modifier = ":t",
      icons = {
          show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
          },
          glyphs = {
              default = "",
              symlink = "",
              git = {
                  unstaged = "",
                  staged = "S",
                  unmerged = "",
                  renamed = "➜",
                  deleted = "",
                  untracked = "U",
                  ignored = "◌",
              },
              folder = {
                  default = "",
                  open = "",
                  empty = "",
                  empty_open = "",
                  symlink = "",
              },
          }
      }
  },
  filters = {
    dotfiles = true,
  },
  update_cwd = true,
  diagnostics = {
      enable = true,
      icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
      },
  },
})
