-- [[ Treesitter ]]
-- nvim-treesitter (main branch) installs parsers and queries; highlighting and
-- indentation are switched on per buffer below. Parsers are compiled with the
-- tree-sitter CLI, so that needs to be installed.

local ts = require 'nvim-treesitter'
ts.install { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'yaml' }

local no_indent = { ruby = true }
local regex_highlight = { ruby = true }

local function attach(buf, lang)
  if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
    return
  end
  if regex_highlight[lang] then
    vim.bo[buf].syntax = 'on'
  end
  if not no_indent[lang] then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
  callback = function(args)
    local buf = args.buf
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end
    -- auto-install missing parsers that nvim-treesitter knows about
    if vim.tbl_contains(ts.get_available(), lang) and not vim.tbl_contains(ts.get_installed 'parsers', lang) then
      ts.install(lang):await(function()
        vim.schedule(function()
          attach(buf, lang)
        end)
      end)
    else
      attach(buf, lang)
    end
  end,
})

-- Text objects and motions
require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      ['@comment.outer'] = 'V', -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
  },
  move = { set_jumps = true },
}

local select = require 'nvim-treesitter-textobjects.select'
for key, obj in pairs {
  ['aa'] = { '@parameter.outer', 'Select around parameter' },
  ['ia'] = { '@parameter.inner', 'Select inside parameter' },
  ['af'] = { '@function.outer', 'Select around function' },
  ['if'] = { '@function.inner', 'Select inside function' },
  ['ac'] = { '@class.outer', 'Select around class/struct' },
  ['ic'] = { '@class.inner', 'Select inside class/struct' },
  ['ii'] = { '@conditional.inner', 'Select inside if' },
  ['ai'] = { '@conditional.outer', 'Select around if' },
  ['il'] = { '@loop.inner', 'Select inside loop' },
  ['al'] = { '@loop.outer', 'Select around loop' },
  ['a/'] = { '@comment.outer', 'Select around comment' },
} do
  vim.keymap.set({ 'x', 'o' }, key, function()
    select.select_textobject(obj[1], 'textobjects')
  end, { desc = obj[2] })
end

local move = require 'nvim-treesitter-textobjects.move'
for _, m in ipairs {
  { ']f', 'goto_next_start', '@function.outer', 'Next function start' },
  { ']C', 'goto_next_start', '@class.outer', 'Next class start' },
  { ']i', 'goto_next_start', '@conditional.outer', 'Next if' },
  { ']l', 'goto_next_start', '@loop.outer', 'Next loop' },
  { ']/', 'goto_next_start', '@comment.outer', 'Next comment' },
  { ']F', 'goto_next_end', '@function.outer', 'Next function end' },
  { '[f', 'goto_previous_start', '@function.outer', 'Previous function start' },
  { '[C', 'goto_previous_start', '@class.outer', 'Previous class start' },
  { '[i', 'goto_previous_start', '@conditional.outer', 'Previous if' },
  { '[l', 'goto_previous_start', '@loop.outer', 'Previous loop' },
  { '[/', 'goto_previous_start', '@comment.outer', 'Previous comment' },
  { '[F', 'goto_previous_end', '@function.outer', 'Previous function end' },
} do
  vim.keymap.set({ 'n', 'x', 'o' }, m[1], function()
    move[m[2]](m[3], 'textobjects')
  end, { desc = m[4] })
end
