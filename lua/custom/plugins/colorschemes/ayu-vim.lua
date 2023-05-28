return {
            'ayu-theme/ayu-vim',
            config = function()
                -- light, mirage, dark
                vim.cmd([[ let ayucolor="mirage" ]])
            end
        }