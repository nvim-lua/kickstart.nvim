---@class TreesitterTextobjectGroup
---@field group_leader string
local TSTO_GROUP = {}

---@param query_group string
---@param opts table<string,string>
---@return any
function TSTO_GROUP:new(query_group, opts)
  self.query_group = query_group
  self.__index = self
  return setmetatable(opts or {
    group_leader = '',
  }, self)
end

---@param key string
---@param object string
---@return TreesitterTextobjectGroup
function TSTO_GROUP:set(key, object)
  self.key = key
  self.object = object
  return self
end

---@param query_name string
---@return string|nil
function TSTO_GROUP:textobject_check(query_name)
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or ''
  local query = vim.treesitter.query.get(lang, self.query_group) or {}

  return vim.iter(query.captures or {}):any(function(val)
    return val:match(query_name)
  end) and query_name or nil
end

---@param attr string|nil
---@return TreesitterTextobjectGroup
function TSTO_GROUP:sel_outer(attr)
  attr = attr or 'outer'

  local obj = TSTO_GROUP:textobject_check(self.object .. '.' .. attr)
  if not obj then
    return self
  end
  obj = '@' .. obj

  vim.keymap.set({ 'x', 'o' }, 'a' .. self.group_leader .. self.key, function()
    require('nvim-treesitter-textobjects.select').select_textobject(obj, self.query_group)
  end, { buffer = true, desc = 'arround ' .. self.object })

  return self
end

---@param attr string|nil
---@return TreesitterTextobjectGroup
function TSTO_GROUP:sel_inner(attr)
  attr = attr or 'inner'

  local obj = TSTO_GROUP:textobject_check(self.object .. '.' .. attr)
  if not obj then
    return self
  end
  obj = '@' .. obj

  vim.keymap.set({ 'x', 'o' }, 'i' .. self.group_leader .. self.key, function()
    require('nvim-treesitter-textobjects.select').select_textobject(obj, self.query_group)
  end, { buffer = true, desc = 'inner ' .. self.object })

  return self
end

---@param opts table<string,string>
---@return TreesitterTextobjectGroup
function TSTO_GROUP:goto_start(opts)
  ---@class opts
  ---@field attribute? string
  ---@field key? string
  ---@field desc? string
  opts = vim.tbl_extend('keep', opts or {}, {
    attribute = 'outer',
    key = self.key,
    desc = 'start',
  })

  local obj = TSTO_GROUP:textobject_check(self.object .. '.' .. opts.attribute)
  if not obj then
    return self
  end
  obj = '@' .. obj

  vim.keymap.set({ 'n', 'x', 'o' }, ']' .. self.group_leader .. opts.key, function()
    require('nvim-treesitter-textobjects.move').goto_next_start(obj, self.query_group)
  end, { buffer = true, desc = 'next ' .. self.object .. ' ' .. opts.desc })
  vim.keymap.set({ 'n', 'x', 'o' }, '[' .. self.group_leader .. opts.key, function()
    require('nvim-treesitter-textobjects.move').goto_previous_start(obj, self.query_group)
  end, { buffer = true, desc = 'previous ' .. self.object .. ' ' .. opts.desc })

  return self
end

---@param attr string|nil
---@return TreesitterTextobjectGroup
function TSTO_GROUP:goto_end(opts)
  attr = attr or 'outer'
  opts = vim.tbl_extend('keep', opts or {}, {
    attribute = 'outer',
    key = self.key:upper(),
    desc = 'end',
  })

  local obj = TSTO_GROUP:textobject_check(self.object .. '.' .. opts.attribute)
  if not obj then
    return self
  end
  obj = '@' .. obj

  vim.keymap.set({ 'n', 'x', 'o' }, ']' .. self.group_leader .. opts.key, function()
    require('nvim-treesitter-textobjects.move').goto_next_end(obj, self.query_group)
  end, { buffer = true, desc = 'next ' .. self.object .. ' ' .. opts.desc })
  vim.keymap.set({ 'n', 'x', 'o' }, '[' .. self.group_leader .. opts.key, function()
    require('nvim-treesitter-textobjects.move').goto_previous_end(obj, self.query_group)
  end, { buffer = true, desc = 'previous ' .. self.object .. ' ' .. opts.desc })

  return self
end

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  -- init = function()
  --   -- Disable entire built-in ftplugin mappings to avoid conflicts.
  --   -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
  --   vim.g.no_plugin_maps = true
  --
  --   -- Or, disable per filetype (add as you like)
  --   -- vim.g.no_python_maps = true
  --   -- vim.g.no_ruby_maps = true
  --   -- vim.g.no_rust_maps = true
  --   -- vim.g.no_go_maps = true
  -- end,
  config = function()
    -- put your config here
    -- configuration
    require('nvim-treesitter-textobjects').setup {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          -- ['@function.outer'] = 'V', -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },

      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
    }

    vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
      desc = 'Set treesitter keymaps when treesitter is avaliable for the file',
      group = vim.api.nvim_create_augroup('TSparser', { clear = true }),
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local has_parser, parser = pcall(vim.treesitter.get_parser, buf, nil, { error = false })

        if not has_parser or parser == nil then
          return
        end

        local tsto = TSTO_GROUP:new('textobjects', { group_leader = 'o' })
        for k, v in pairs {
          -- ['b'] = 'block', -- for brace-less languages like python
          ['c'] = 'class',
          ['f'] = 'function',
          ['i'] = 'conditional',
          ['l'] = 'loop',
          ['p'] = 'parameter',
          ['r'] = 'return',
          ['t'] = 'attribute',
          ['x'] = 'regex',
        } do
          tsto:set(k, v):sel_outer():sel_inner():goto_start():goto_end()
        end

        tsto:set('{', 'block'):sel_outer():sel_inner():goto_start():goto_end { key = '}' }
        tsto:set('(', 'call'):sel_outer():sel_inner():goto_start():goto_end { key = ')' }
        tsto:set('/', 'comment'):sel_outer():sel_inner():goto_start()
        tsto:set(';', 'statement'):sel_outer():goto_start():goto_end { key = ':' }
        tsto
          :set('=', 'assignment')
          :sel_outer()
          :sel_inner('rhs')
          :goto_start({ attribute = 'lhs' })
          :goto_start { attribute = 'rhs', key = '-', desc = 'rhs' }
      end,
    })
  end,
}
