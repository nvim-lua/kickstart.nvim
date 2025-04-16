local ls = require 'luasnip'

-- TODO LO DE ABAJO QUEDA COMENTADO Y POR AHORA VOY A USAR LAS TECLAS POR DEFECTO YA QUE NO ESTOY PUDIENDO
-- CAMBIAR LOS KEYMAPS
-- Mis keymaps
-- "Este es para expandir el snippet o saltar al siguiente item del snippet
-- vim.keymap.set({ 'i', 's' }, '<C-k>', function()
--   if ls.expand_or_jumpable() then
--     ls.expand_or_jump()
--   end
-- end, { silent = true })
--
-- -- Este es para moverte al item anterior del snippet
-- vim.keymap.set({ 'i', 's' }, '<C-j>', function()
--   if ls.jumpable(-1) then
--     ls.jump(-1)
--   end
-- end, { silent = true })
--
-- -- Este es para poder elegir los choice nodes
-- vim.keymap.set('i', '<C-l>', function()
--   if ls.choince_active() then
--     ls.change_choice(1)
--   end
-- end)
--
-- -- Este shorcut es para recargar los snippets para que no tenga que cerrar nvim
-- -- y volverlo a abir cada vez que hago un cambio
vim.keymap.set('n', '<leader><localleader>s', '<cmd>source C:/Users/ricar/AppData/Local/nvim/lua/luaconfig/luasnip.lua<CR>')

require('luasnip.loaders.from_lua').load { paths = 'C:/Users/ricar/AppData/Local/nvim/lua/snippets/' }
