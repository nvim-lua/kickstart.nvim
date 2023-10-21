vim.opt.statusline = "%!v:lua.require('custom.statusline.statusline').run()"

function SetColors(theme)
  for hlgroupName, hlgroup_vals in pairs(theme) do
    local hlname = hlgroupName
    local opts = {}

    for optName, optVal in pairs(hlgroup_vals) do
      opts[optName] = optVal
    end
    vim.api.nvim_set_hl(0, hlname, opts)
  end
end

Theme = require('custom.statusline.theme')
SetColors(Theme)
