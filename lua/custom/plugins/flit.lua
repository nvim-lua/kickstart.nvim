return {
  "ggandor/flit.nvim",
  keys = function()
    ---@type LazyKeys[]
    local ret = {}
    for _, key in ipairs({ "f", "F", "t", "T" }) do
      ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
    end
    return ret
  end,
  opts = { labeled_modes = "nx" },
}
