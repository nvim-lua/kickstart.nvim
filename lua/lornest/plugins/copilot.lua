return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = "<S-Right>",
                        accept_word = false,
                        accept_line = false,
                        next = "<A-Down>",
                        prev = "<A-Up>",
                        dismiss = "<C-]>",
                    }
                }
            })
        end
    },
}
