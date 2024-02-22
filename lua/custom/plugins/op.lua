return {
    'pstuifzand/op.nvim',
    build = 'make install',
    config = function()
        require('op').setup({
            op_cli_path = '/usr/bin/op',
        })
    end
}
