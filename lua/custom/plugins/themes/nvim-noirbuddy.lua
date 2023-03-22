return {
            "jesseleite/nvim-noirbuddy",
            dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
            config = function()
                require('noirbuddy').setup {
                    preset = 'miami-nights',
                }
            end
        }