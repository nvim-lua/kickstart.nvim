return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require('telescope')
    telescope.setup {
      extensions = {
        file_browser = {
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
        },
      },
    }

    telescope.load_extension("file_browser")

    -- Keymaps

    -- vim.api.nvim_set_keymap(
    --   "n",
    --   "<space>sb",
    --   ":Telescope file_browser<CR>",
    --   { noremap = true }
    -- )

    -- open file_browser with the path of the current buffer
    vim.api.nvim_set_keymap(
      "n",
      "<space>sb",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { noremap = true }
    )
  end
}
