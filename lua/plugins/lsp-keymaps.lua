local M = {}

M._keys = nil

---@return table
function M.get()
  if M._keys then
    return M._keys
  end

  -- Standard LSP Keybindings (No LazyVim)
  M._keys = {
    { '<leader>cl', '<cmd>LspInfo<cr>', desc = 'LSP Info' },
    { 'gd', vim.lsp.buf.definition, desc = 'Go to Definition' },
    { 'gr', vim.lsp.buf.references, desc = 'References' },
    { 'gI', vim.lsp.buf.implementation, desc = 'Go to Implementation' },
    { 'gy', vim.lsp.buf.type_definition, desc = 'Go to Type Definition' },
    { 'gD', vim.lsp.buf.declaration, desc = 'Go to Declaration' },
    { 'K', vim.lsp.buf.hover, desc = 'Hover' },
    { 'gK', vim.lsp.buf.signature_help, desc = 'Signature Help' },
    { '<C-k>', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help' },
    { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' } },
    { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
    {
      '<leader>cR',
      function()
        if require 'snacks.rename' then
          require('snacks.rename').rename_file()
        else
          print 'Snacks rename not available'
        end
      end,
      desc = 'Rename File',
      mode = { 'n' },
      has = { 'workspace/didRenameFiles', 'workspace/willRenameFiles' },
    },
    { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename', has = 'rename' },
  }

  return M._keys
end

---@param buffer number
function M.on_attach(_, buffer)
  for _, key in pairs(M.get()) do
    vim.keymap.set(key.mode or 'n', key[1], key[2], { buffer = buffer, desc = key.desc, silent = true })
  end
end

return M
-- local M = {}
--
-- ---@type LazyKeysLspSpec[]|nil
-- M._keys = nil
--
-- ---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
-- ---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}
--
-- ---@return LazyKeysLspSpec[]
-- function M.get()
--   if M._keys then
--     return M._keys
--   end
--   -- stylua: ignore
--   M._keys = {
--     { "<leader>cl", "<cmd>LspInfo<cr>",                                 desc = "LSP Info" },
--     { "gd",         vim.lsp.buf.definition,                             desc = "Go to Definition",           has = "definition" },
--     { "gr",         vim.lsp.buf.references,                             desc = "References",                 nowait = true },
--     { "gI",         vim.lsp.buf.implementation,                         desc = "Go to Implementation" },
--     { "gy",         vim.lsp.buf.type_definition,                        desc = "Go to Type Definition" },
--     { "gD",         vim.lsp.buf.declaration,                            desc = "Go to Declaration" },
--     { "K",          function() return vim.lsp.buf.hover() end,          desc = "Hover" },
--     { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",             has = "signatureHelp" },
--     { "<C-k>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                          desc = "Signature Help", has = "signatureHelp" },
--     { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code Action",                mode = { "n", "v" },     has = "codeAction" },
--     { "<leader>cc", vim.lsp.codelens.run,                               desc = "Run CodeLens",               mode = { "n", "v" },     has = "codeLens" },
--     { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "Refresh & Display CodeLens", mode = { "n" },          has = "codeLens" },
--     {
--       "<leader>cR",
--       function()
--         if require("snacks.rename") then
--           require("snacks.rename").rename_file()
--         else
--           print("Snacks rename not available")
--         end
--       end,
--       desc = "Rename File",
--       mode = { "n" },
--       has = { "workspace/didRenameFiles", "workspace/willRenameFiles" }
--     },
--     { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
--     {
--       "<leader>cA",
--       function()
--         if require("lazyvim.lsp.action") then
--           require("lazyvim.lsp.action").source()
--         else
--           print("LazyVim LSP action not available")
--         end
--       end,
--       desc = "Source Action",
--       has = "codeAction"
--     },
--     {
--       "]]",
--       function()
--         if require("snacks.words") then
--           require("snacks.words").jump(vim.v.count1)
--         end
--       end,
--       has = "documentHighlight",
--       desc = "Next Reference",
--       cond = function() return require("snacks.words").is_enabled() end
--     },
--     {
--       "[[",
--       function()
--         if require("snacks.words") then
--           require("snacks.words").jump(-vim.v.count1)
--         end
--       end,
--       has = "documentHighlight",
--       desc = "Previous Reference",
--       cond = function() return require("snacks.words").is_enabled() end
--     },
--     {
--       "<A-n>",
--       function()
--         if require("snacks.words") then
--           require("snacks.words").jump(vim.v.count1, true)
--         end
--       end,
--       has = "documentHighlight",
--       desc = "Next Reference",
--       cond = function() return require("snacks.words").is_enabled() end
--     },
--     {
--       "<A-p>",
--       function()
--         if require("snacks.words") then
--           require("snacks.words").jump(-vim.v.count1, true)
--         end
--       end,
--       has = "documentHighlight",
--       desc = "Previous Reference",
--       cond = function() return require("snacks.words").is_enabled() end
--     },
--   }
--
--   return M._keys
-- end
--
-- ---@param buffer number
-- ---@param method string|string[]
-- function M.has(buffer, method)
--   if type(method) == 'table' then
--     for _, m in ipairs(method) do
--       if M.has(buffer, m) then
--         return true
--       end
--     end
--     return false
--   end
--   method = method:find '/' and method or 'textDocument/' .. method
--   local clients = vim.lsp.get_active_clients { bufnr = buffer }
--   for _, client in ipairs(clients) do
--     if client.supports_method(method) then
--       return true
--     end
--   end
--   return false
-- end
--
-- ---@return LazyKeysLsp[]
-- function M.resolve(buffer)
--   local Keys = require 'lazy.core.handler.keys'
--   if not Keys.resolve then
--     return {}
--   end
--   local spec = vim.tbl_extend('force', {}, M.get())
--   local opts = require 'nvim-lspconfig'
--   local clients = vim.lsp.get_active_clients { bufnr = buffer }
--   for _, client in ipairs(clients) do
--     local maps = opts.servers and opts.servers[client.name] and opts.servers[client.name].keys or {}
--     vim.list_extend(spec, maps)
--   end
--   return Keys.resolve(spec)
-- end
--
-- function M.on_attach(_, buffer)
--   local Keys = require 'lazy.core.handler.keys'
--   local keymaps = M.resolve(buffer)
--
--   for _, keys in pairs(keymaps) do
--     local has = not keys.has or M.has(buffer, keys.has)
--     local cond = not (keys.cond == false or ((type(keys.cond) == 'function') and not keys.cond()))
--
--     if has and cond then
--       local opts = Keys.opts(keys)
--       opts.cond = nil
--       opts.has = nil
--       opts.silent = opts.silent ~= false
--       opts.buffer = buffer
--       vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
--     end
--   end
-- end
--
-- return M
