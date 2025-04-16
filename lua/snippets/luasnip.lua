local ls = require 'luasnip'

ls.setup {
  update_events = { 'TextChanged', 'TextChangedI' },
  enable_autosnippets = true,
  -- NOTE: Falta agregar las crazy highlights del video 3 de TJDeVries
}
