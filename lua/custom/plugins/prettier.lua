return {
    'MunifTanjim/prettier.nvim',

    config = function()

        local prettier = require("prettier")

        prettier.setup({
            bin = 'prettierd',
            filetypes = {
                "css",
                "graphql",
                "html",
                "javascript",
                "javascriptreact",
                "json",
                "less",
                "markdown",
                "scss",
                "typescript",
                "typescriptreact",
                "yaml",
            },
        })

        prettier.setup({
            ["null-ls"] = {
                condition = function()
                    return prettier.config_exists({
                        -- if `false`, skips checking `package.json` for `"prettier"` key
                        check_package_json = true,
                    })
                end,
                runtime_condition = function(params)
                    -- return false to skip running prettier
                    return true
                end,
                timeout = 1000,
            }
        })

    end,
}
