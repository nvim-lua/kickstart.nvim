return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    cmp.setup({
      window = {
        completion = {
          border = "single",
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuThumb,Search:None",
        },
        documentation = {
          border = "single",
        },
      },
    })
  end,
}
