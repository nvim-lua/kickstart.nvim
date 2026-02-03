return {
    -- SchemaStore for YAML schemas (GitHub Actions, Docker Compose, etc.)
    {
        'b0o/SchemaStore.nvim',
        lazy = true,
        version = false,
    },

    -- Helm filetype detection and syntax
    {
        'towolf/vim-helm',
        ft = 'helm',
    },
}
