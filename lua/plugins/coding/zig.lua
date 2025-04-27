---@diagnostic disable: undefined-global
return {
  "ziglang/zig.vim",
  ft = "zig",
  config = function()
    -- Enable auto-formatting on save
    vim.g.zig_fmt_autosave = 1
  end,
}
