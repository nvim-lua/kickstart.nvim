return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        number = true,
        relativenumber = true,
        centralize_selection = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        add_trailing = true,
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- Sync nvim-tree with current file when file changes (BufEnter)
    local function sync_nvim_tree()
      local api = require("nvim-tree.api")

      -- Check if nvim-tree is open
      local is_open = api.tree.is_visible()
      if is_open then
        api.tree.find_file(vim.fn.expand("%"), true)
      end
    end

    -- Trigger sync_nvim_tree when buffer is entered
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        sync_nvim_tree()
      end,
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    -- keymap.set('n', '<C>)', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file explorer on current file' }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

    -- New ones I'm adding just for testing and hopefully that works
    -- keymap.set('n', 'h', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' }) -- collapse file explorer
  end,
}
