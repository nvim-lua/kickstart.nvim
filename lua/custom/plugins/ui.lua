return {
  { 'folke/snacks.nvim', opts = { image = { enabled = true } } },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    git_status = {
      enabled = false, -- <--- вот это
    },
    opts = {
      window = {
        mappings = {
          ['P'] = {
            'toggle_preview',
            config = { use_float = true, use_snacks_image = true, use_image_nvim = true },
          },
        },
      },
    },
    lazy = false,
  },
}
