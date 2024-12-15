return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = function()
        -- Gruvbox shenanigans
        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd.colorscheme "gruvbox"
    end
}