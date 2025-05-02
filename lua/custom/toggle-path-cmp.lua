local cmp = require 'cmp'

local M = {}

function M.toggle_path_completion()
  local snippet = cmp.get_config().snippet
  local completion = cmp.get_config().completion
  local mapping = cmp.get_config().mapping
  local sources = cmp.get_config().sources
  local path_enabled = false

  for _, source in ipairs(sources) do
    if source.name == 'path' then
      path_enabled = true
      break
    end
  end

  if path_enabled then
    cmp.setup {
      snippet,
      completion,
      mapping,
      sources = {
        { name = 'lazydev', group_index = 0 },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
    print 'Path completion disabled'
  else
    cmp.setup {
      snippet,
      completion,
      mapping,
      sources = {
        { name = 'lazydev', group_index = 0 },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
    print 'Path completion enabled'
  end
end

return M
