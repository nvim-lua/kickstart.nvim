return {

  -- [[Autopairs]]
  -- doubles up common surrounding characters
  { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },

  -- [[Comment]]
  -- comments code with 'gcc' & 'gbc'
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  -- { 'nvim-ts-autotag',       opts = {} },
}
