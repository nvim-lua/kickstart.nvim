return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    jump = {
      pos = 'range',
    },
    modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = false,
        jump_labels = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
  },
}
