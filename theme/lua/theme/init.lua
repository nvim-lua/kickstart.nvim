local M = {}

function M.setup()
  local colors = {
    purple = '#7f8cff',
    black = '#000000',
    white = '#ededed',
    orange = '#ffaa00',
    green = '#00c427',
    red = '#e60000',
    blue = '#00a6ff',
  }

  local highlights = {

    Normal = { fg = colors.black, bg = colors.white },
    CursorLine = { bg = '#e6e6e6' },
    LineNr = { fg = colors.purple },

    -- Neovim text configurations --
    Function = { fg = colors.purple },
    Identifier = { fg = colors.purple },
    MoreMsg = { fg = colors.purple },
    String = { fg = colors.purple },
    QuickFixLine = { fg = colors.purple },
    Question = { fg = colors.purple },

    -- Other configuratiosn --
    Special = { fg = colors.purple },

    -- Todo configurations --
    TodoFgTODO = { fg = colors.blue },
    TodoFgNOTE = { fg = colors.blue },

    TodoBgTODO = { fg = colors.white, bg = colors.blue },
    TodoBgNOTE = { fg = colors.white, bg = colors.blue },

    -- [ TREESITTER RELATED / TEXT CONFIGURATIONS ] --

    -- Literals --
    ['@string'] = { fg = colors.purple },
    ['@boolean'] = { fg = colors.purple },
    ['@character'] = { fg = colors.purple },
    ['@number'] = { fg = colors.orange },

    -- Identifiers --
    ['@variable'] = { fg = colors.black },
    ['@module'] = { fg = colors.black },

    -- Types --
    ['@type'] = { fg = colors.purple },
    ['@property'] = { fg = colors.purple },

    -- Keyword related --
    ['@keyword'] = { fg = colors.purple },

    -- Comment related --
    ['@comment'] = { fg = colors.orange },
    ['@comment.warning'] = { fg = colors.orange },
    ['@comment.todo'] = { fg = colors.green },
    ['@comment.documentation'] = { fg = colors.blue },
    ['@comment.note'] = { fg = colors.blue },
    ['@comment.error'] = { fg = colors.red },

    -- Functions --
    ['@function'] = { fg = colors.purple },
    ['@function.builtin'] = { fg = colors.black },
    ['@constructor'] = { fg = colors.black },
    ['@operator'] = { fg = colors.black },

    -- Punctuation --
    ['@punctuation'] = { fg = colors.black },

    -- [ NEOTREE COLOR CONFIGURATIONS ] --
    Removed = { fg = colors.red },
    NeoTreeGitUntracked = { fg = colors.purple },
    Changed = { fg = colors.purple },
    Directory = { fg = colors.purple },
    Added = { fg = colors.green },

    -- Diagnostic colors --
    DiagnosticInfo = { fg = colors.purple },
    DiagnosticOk = { fg = colors.purple },
    DiagnosticWarn = { fg = colors.orange },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return M
