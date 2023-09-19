return {
    "olrtg/nvim-emmet",

    config = function()
        vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
}
