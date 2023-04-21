return {
    'ray-x/lsp_signature.nvim',
    config = function()
        local cfg = {
            floating_window_above_cur_line = true,
            doc_lines = 0,
        }
        require('lsp_signature').setup(cfg)
    end
}
