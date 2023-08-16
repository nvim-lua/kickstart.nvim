-- Neotree mappings

return function(buffer)
  local api = require "nvim-tree.api"

  local nmap = require("core.utils").createNmap({
    buffer = buffer,
    desc = 'nvim-tree: : ',
    noremap = true,
    silent = true,
    nowait = true
  })

  -- default mappings
  api.config.mappings.default_on_attach(buffer)

  nmap('<leader><space>', api.tree.toggle, 'File Tree')
  nmap('t', api.node.open.tab, 'Toggle Node')
  nmap('<leader>f', function()
    api.tree.open({
      find_file = true
    })
  end, 'Reveal File In Tree')
end
