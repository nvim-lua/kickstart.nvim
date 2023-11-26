require("telescope").load_extension("harpoon")

require('which-key').register {
    ['<leader>h'] = {
        name = "[H]arpoon",
        m = { "<cmd>:lua require('harpoon.mark').add_file()<cr>", "[M]ark" },
        t = { "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<cr>", "[T]oggle Menu" },
        p = { "<cmd>:lua require('harpoon.ui').nav_prev()<cr>", "[P]revious File" },
        n = { "<cmd>:lua require('harpoon.ui').nav_next()<cr>", "[N]ext File" },
    },
}
