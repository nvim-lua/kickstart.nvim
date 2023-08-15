return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {desc = "[g]it [s]tatus"})

        local Lornest_Fugitive = vim.api.nvim_create_augroup("Lornest_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = Lornest_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()

                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git('push')
                end, {buffer = bufnr, remap = false, desc = "git [P]ush"})

                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('pull')
                end, {buffer = bufnr, remap = false, desc = "git [p]ull"})
            end,
    })
    end
}
