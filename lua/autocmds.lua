vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.py" },
    desc = "Auto-format Python files after saving",
    callback = function()
        local fileName = vim.api.nvim_buf_get_name(0)
        vim.cmd(":silent !black --preview -q " .. fileName)
        vim.cmd(":silent !isort --profile black --float-to-top -q " .. fileName)
    end,
    group = autocmd_group,
})
