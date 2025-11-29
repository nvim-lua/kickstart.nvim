return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- auto close if it's the last window
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = { enabled = true }, -- auto-focus current file
        use_libuv_file_watcher = true,            -- auto-refresh
      },
    })

    -- Keymaps: toggle Neo-tree easily
    vim.keymap.set("n", "<leader>n", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
  end,
}
