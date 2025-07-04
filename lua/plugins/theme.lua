-- Custom theme
return {
  {
    name = 'vague-theme',
    dir = vim.fn.stdpath('config'),
    config = function()
      -- Vague theme
      local function setup_vague_theme()
        vim.cmd 'highlight clear'
        if vim.fn.exists 'syntax_on' == 1 then
          vim.cmd 'syntax reset'
        end

        vim.o.background = 'dark'
        vim.g.colors_name = 'vague'

        local c = {
          black = '#000000',
          dark_gray = '#1b1c1d',
          gray = '#2d2d30',
          light_gray = '#5c5c6e',
          white = '#cdcdcd',
          foreground = '#be8c8c',
          cursor = '#c2c2c2',
          line_bg = '#282830',
          active_fg = '#deb896',
          focus_fg = '#ddb795',
          property = '#b6c4dc',
          number = '#C2966B',
          parameter = '#d9c8ce',
          class = '#b06767',
          namespace = '#748fa7',
          keyword = '#7894AB',
          control_kw = '#748fa7',
          interface = '#d57d7d',
          func = '#be8c8c',
          operator = '#CDCDCD',
          string = '#deb896',
          comment = '#8c8c8c',
          error = '#d2788c',
          warning = '#e6be8c',
          info = '#61a0c4',
        }

        local function hi(group, fg, bg, attr)
          local cmd = 'highlight ' .. group
          if fg and fg ~= '' then
            cmd = cmd .. ' guifg=' .. fg
          end
          if bg and bg ~= '' then
            cmd = cmd .. ' guibg=' .. bg
          end
          if attr and attr ~= '' then
            cmd = cmd .. ' gui=' .. attr
          end
          vim.cmd(cmd)
        end

        -- Basic highlights
        hi('Normal', c.white, c.black, '')
        hi('Cursor', c.black, c.cursor, '')
        hi('CursorLine', '', c.line_bg, '')
        hi('CursorColumn', '', c.line_bg, '')
        hi('LineNr', c.light_gray, '', '')
        hi('CursorLineNr', c.focus_fg, '', 'bold')
        hi('Visual', '', '#404040', '')
        hi('VisualNOS', '', '#404040', '')
        hi('Search', c.black, c.number, '')
        hi('IncSearch', c.black, c.active_fg, '')
        hi('MatchParen', '', '#0064001a', '')
        hi('VertSplit', c.gray, '', '')
        hi('WinSeparator', c.gray, '', '')
        hi('StatusLine', c.active_fg, c.black, '')
        hi('StatusLineNC', c.foreground, c.black, '')
        hi('TabLine', c.foreground, c.black, '')
        hi('TabLineFill', '', c.black, '')
        hi('TabLineSel', c.active_fg, c.black, 'bold')
        hi('Pmenu', c.warning, c.black, '')
        hi('PmenuSel', c.active_fg, '#232426', '')
        hi('PmenuSbar', '', c.gray, '')
        hi('PmenuThumb', '', c.light_gray, '')
        hi('FloatBorder', c.gray, '', '')
        hi('NormalFloat', c.white, c.black, '')
        hi('Folded', c.comment, '#8484841c', '')
        hi('FoldColumn', c.light_gray, '', '')
        hi('DiffAdd', '', '#587c0c4c', '')
        hi('DiffChange', '', '#0c7d9d52', '')
        hi('DiffDelete', '', '#94151b54', '')
        hi('DiffText', '', '#bcbcbc14', '')
        hi('DiagnosticError', c.error, '', '')
        hi('DiagnosticWarn', c.warning, '', '')
        hi('DiagnosticInfo', c.info, '', '')
        hi('DiagnosticHint', c.comment, '', '')
        hi('ErrorMsg', c.error, '', '')
        hi('WarningMsg', c.warning, '', '')
        hi('ModeMsg', c.active_fg, '', '')
        hi('MoreMsg', c.active_fg, '', '')
        hi('Question', c.active_fg, '', '')

        -- Syntax
        hi('Comment', c.comment, '', 'italic')
        hi('Constant', c.number, '', '')
        hi('String', c.string, '', '')
        hi('Character', c.string, '', '')
        hi('Number', c.number, '', '')
        hi('Boolean', c.number, '', '')
        hi('Float', c.number, '', '')
        hi('Identifier', c.property, '', '')
        hi('Function', c.func, '', '')
        hi('Statement', c.keyword, '', '')
        hi('Conditional', c.control_kw, '', '')
        hi('Repeat', c.control_kw, '', '')
        hi('Label', c.keyword, '', '')
        hi('Operator', c.operator, '', '')
        hi('Keyword', c.keyword, '', '')
        hi('Exception', c.control_kw, '', '')
        hi('PreProc', c.keyword, '', '')
        hi('Include', c.keyword, '', '')
        hi('Define', c.keyword, '', '')
        hi('Macro', c.keyword, '', '')
        hi('PreCondit', c.keyword, '', '')
        hi('Type', c.class, '', '')
        hi('StorageClass', c.keyword, '', '')
        hi('Structure', c.class, '', '')
        hi('Typedef', c.class, '', '')
        hi('Special', c.operator, '', '')
        hi('SpecialChar', c.operator, '', '')
        hi('Tag', c.class, '', '')
        hi('Delimiter', c.operator, '', '')
        hi('SpecialComment', c.comment, '', 'bold')
        hi('Debug', c.error, '', '')

        -- TreeSitter
        hi('@variable', c.white, '', '')
        hi('@variable.builtin', c.class, '', '')
        hi('@variable.parameter', c.parameter, '', '')
        hi('@variable.member', c.property, '', '')
        hi('@constant', c.number, '', '')
        hi('@constant.builtin', c.number, '', '')
        hi('@constant.macro', c.keyword, '', '')
        hi('@string', c.string, '', '')
        hi('@string.escape', c.operator, '', '')
        hi('@string.special', c.operator, '', '')
        hi('@character', c.string, '', '')
        hi('@character.special', c.operator, '', '')
        hi('@number', c.number, '', '')
        hi('@boolean', c.number, '', '')
        hi('@float', c.number, '', '')
        hi('@function', c.func, '', '')
        hi('@function.builtin', c.func, '', '')
        hi('@function.call', c.func, '', '')
        hi('@function.macro', c.func, '', '')
        hi('@method', c.func, '', '')
        hi('@method.call', c.func, '', '')
        hi('@constructor', c.class, '', '')
        hi('@parameter', c.parameter, '', '')
        hi('@keyword', c.keyword, '', '')
        hi('@keyword.function', c.keyword, '', '')
        hi('@keyword.operator', c.keyword, '', '')
        hi('@keyword.return', c.control_kw, '', '')
        hi('@keyword.conditional', c.control_kw, '', '')
        hi('@keyword.repeat', c.control_kw, '', '')
        hi('@keyword.exception', c.control_kw, '', '')
        hi('@operator', c.operator, '', '')
        hi('@punctuation.delimiter', c.operator, '', '')
        hi('@punctuation.bracket', c.operator, '', '')
        hi('@punctuation.special', c.operator, '', '')
        hi('@type', c.class, '', '')
        hi('@type.builtin', c.class, '', '')
        hi('@type.definition', c.class, '', '')
        hi('@type.qualifier', c.keyword, '', '')
        hi('@property', c.property, '', '')
        hi('@field', c.property, '', '')
        hi('@namespace', c.namespace, '', '')
        hi('@module', c.namespace, '', '')
        hi('@label', c.keyword, '', '')
        hi('@comment', c.comment, '', 'italic')
        hi('@tag', c.class, '', '')
        hi('@tag.attribute', c.property, '', '')
        hi('@tag.delimiter', c.operator, '', '')

        -- LSP
        hi('@lsp.type.class', c.class, '', '')
        hi('@lsp.type.interface', c.interface, '', '')
        hi('@lsp.type.namespace', c.namespace, '', '')
        hi('@lsp.type.parameter', c.parameter, '', '')
        hi('@lsp.type.property', c.property, '', '')
        hi('@lsp.type.variable', c.white, '', '')
        hi('@lsp.type.function', c.func, '', '')
        hi('@lsp.type.method', c.func, '', '')
        hi('@lsp.type.macro', c.func, '', '')
        hi('@lsp.mod.defaultLibrary', c.func, '', '')
        hi('LspSignatureActiveParameter', c.parameter, '', 'bold')
        hi('LspCodeLens', c.comment, '', '')
        hi('LspInlayHint', c.comment, '', 'italic')

        -- Language-specific highlights (after general highlights)
        hi('@type.go', c.keyword, '', '')
        hi('@type.builtin.go', c.keyword, '', '')
        hi('@lsp.type.type.go', c.keyword, '', '')
        hi('@keyword.function.go', c.control_kw, '', '')
        hi('@keyword.return.go', '#4a5f7a', '', '')
        hi('@function.macro.rust', c.class, '', '')
        hi('@lsp.type.decorator.rust', c.class, '', '')
        hi('@lsp.typemod.decorator.attribute.rust', c.class, '', '')
        hi('@lsp.typemod.decorator.defaultLibrary.rust', c.class, '', '')
        hi('@lsp.typemod.decorator.library.rust', c.class, '', '')
        hi('@keyword.return.c_sharp', '#4a5f7a', '', '')
        hi('@keyword.exception.c_sharp', '#8b4242', '', '')
        hi('@lsp.type.parameter.cs', c.parameter, '', '')

        -- Telescope
        hi('TelescopeNormal', c.white, c.black, '')
        hi('TelescopeBorder', c.gray, '', '')
        hi('TelescopeSelection', c.active_fg, '#232426', '')
        hi('TelescopeSelectionCaret', c.active_fg, '', '')
        hi('TelescopeMatching', c.number, '', '')

        -- Which-key
        hi('WhichKey', c.property, '', '')
        hi('WhichKeyGroup', c.class, '', '')
        hi('WhichKeyDesc', c.white, '', '')
        hi('WhichKeyFloat', '', c.black, '')
        hi('WhichKeyBorder', c.gray, '', '')

        -- Terminal colors
        vim.g.terminal_color_0 = c.black
        vim.g.terminal_color_1 = '#cd3131'
        vim.g.terminal_color_2 = '#0dbc79'
        vim.g.terminal_color_3 = '#e5e510'
        vim.g.terminal_color_4 = '#2472c8'
        vim.g.terminal_color_5 = '#bc3fbc'
        vim.g.terminal_color_6 = '#11a8cd'
        vim.g.terminal_color_7 = '#e5e5e5'
        vim.g.terminal_color_8 = '#666666'
        vim.g.terminal_color_9 = '#f14c4c'
        vim.g.terminal_color_10 = '#23d18b'
        vim.g.terminal_color_11 = '#f5f543'
        vim.g.terminal_color_12 = '#3b8eea'
        vim.g.terminal_color_13 = '#d670d6'
        vim.g.terminal_color_14 = '#29b8db'
        vim.g.terminal_color_15 = '#e5e5e5'
      end

      setup_vague_theme()
    end,
  },
}