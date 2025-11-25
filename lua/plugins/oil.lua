return {
  "stevearc/oil.nvim",
  event = 'VimEnter', -- Loads the plugin when nvim finishes starting up.
  lazy = false,
 	dependencies = { "nvim-tree/nvim-web-devicons" },
 	config = function ()
 		require("oil").setup({})
 	end
}

