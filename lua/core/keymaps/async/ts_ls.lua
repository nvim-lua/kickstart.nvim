return function(buffer, cmds)
  local nmap = require("core.utils").createNmap({
    buffer = buffer,
    desc = 'LSP: ',
  })

  nmap('<leader>oi', cmds.organize_imports, 'OrganizeImports')
end
