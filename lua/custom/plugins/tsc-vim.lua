return {
    'dmmulroy/tsc.nvim',
    dependencies = {
        'rcarriga/nvim-notify'
    },
    config = function()
        require('tsc').setup({
            spinner = { "(╯°□°)╯︵ ┻━┻", "(╯°□°)╯︵ ┻━┻", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
            pretty_errors = true,
        })
    end
}