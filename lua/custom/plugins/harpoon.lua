return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)
    vim.keymap.set("n", "<leader>hr", function()
        harpoon:list():remove()
      if (harpoon.ui.open) then
        harpoon:list()
        harpoon.ui:refresh()
      end
    end)
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hk", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<leader>hj", function()
			harpoon:list():next()
		end)
	end,
}
