vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim"
})

-- Default options:
require("gruvbox").setup({
  terminal_colors = false, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = false,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {

    -- 1. Darken all root background variants (from hardest to softest)
    dark0_hard = "#0d0f10", -- The main background when contrast = "hard"
    dark0      = "#121415", -- The standard medium background
    dark0_soft = "#181a1b", -- The background when contrast = "soft"

    -- 2. Darken the secondary UI layer (used for active lines and selection areas)
    dark1      = "#1d1f21", -- Used for things like CursorLine background
    dark2      = "#282a2e", -- Used for subtle UI dividers
    dark3      = "#373b41", -- Used for inactive tabs or panels
    dark4      = "#4c566a", -- Used for fold markers and subtle lines

    -- 3. Soften the text color (prevents blinding stark white text against the dark backdrop)
    light0_hard = "#e5e9f0",
    light0      = "#d8dee9", -- The main text color (foreground)
    light0_soft = "#c8d0e0",
  },
overrides = {
  -- Base palette aliases
  GruvboxRed = { fg = "#b86f6f" },
  GruvboxGreen = { fg = "#729073" },
  GruvboxYellow = { fg = "#9f8c5b" },
  GruvboxBlue = { fg = "#6f8698" },
  GruvboxPurple = { fg = "#7f6f97" },
  GruvboxAqua = { fg = "#678b86" },
  GruvboxOrange = { fg = "#a97f5e" },
  GruvboxGray = { fg = "#928374" },
  GruvboxFg0 = { fg = "#d8dee9" },
  GruvboxFg1 = { fg = "#c2cad7" },
  GruvboxFg2 = { fg = "#a9b3c1" },
  GruvboxFg3 = { fg = "#8892a0" },
  GruvboxFg4 = { fg = "#6f7784" },
  GruvboxBg0 = { fg = "#181a1b" },
  GruvboxBg1 = { fg = "#1d1f21" },
  GruvboxBg2 = { fg = "#282a2e" },
  GruvboxBg3 = { fg = "#373b41" },
  GruvboxBg4 = { fg = "#4c566a" },

  -- Core syntax
  Comment = { fg = "#6b6863", italic = true },
  ["@comment"] = { fg = "#6b6863", italic = true },

  String = { fg = "#878057" },
  ["@string"] = { fg = "#879050" },
  ["@string.escape"] = { fg = "#7a8b9a" },
  ["@string.special"] = { fg = "#7a8b9a" },
  ["@string.regex"] = { fg = "#7a8b9a" },
  ["@string.special.url"] = { fg = "#7a8b9a", underline = true },

  Keyword = { fg = "#a86a63" },
  ["@keyword"] = { fg = "#a86a63" },
  ["@keyword.conditional"] = { fg = "#a86a63" },
  ["@keyword.function"] = { fg = "#a86a63" },
  ["@keyword.import"] = { fg = "#8f8780" },
  ["@keyword.repeat"] = { fg = "#a86a63" },
  ["@keyword.return"] = { fg = "#a86a63" },

  Conditional = { fg = "#a86a63" },
  Repeat = { fg = "#a86a63" },
  Label = { fg = "#a86a63" },
  Statement = { fg = "#b55a5a" },
  Exception = { fg = "#a67b7b" },

  Include = { fg = "#8f8780" },
  PreProc = { fg = "#8f8a85" },
  Define = { fg = "#8f8a85" },
  Macro = { fg = "#8a7b9a" },
  PreCondit = { fg = "#8f8a85" },
  StorageClass = { fg = "#a97f5e" },
  Structure = { fg = "#8a9a8b" },
  Typedef = { fg = "#a89688" },

  Type = { fg = "#a89688" },
  ["@type"] = { fg = "#a89688" },
  ["@type.builtin"] = { fg = "#a89688" },
  ["@type.definition"] = { fg = "#a89688" },
  ["@type.qualifier"] = { fg = "#8f8a85" },

  Function = { fg = "#c2a073" },
  ["@function"] = { fg = "#c2a073" },
  ["@function.builtin"] = { fg = "#c2a073" },
  ["@function.call"] = { fg = "#c2a073" },
  ["@method"] = { fg = "#c4a88b" },
  Method = { fg = "#c4a88b" },
  ["@method.call"] = { fg = "#c4a88b" },

  Identifier = { fg = "#a39a91" },
  ["@variable"] = { fg = "#a39a91" },
  ["@variable.builtin"] = { fg = "#8f8780" },
  ["@variable.parameter"] = { fg = "#a1958a" },
  ["@variable.member"] = { fg = "#9a8b7b" },
  ["@parameter"] = { fg = "#a1958a" },
  Parameter = { fg = "#a1958a" },
  Field = { fg = "#9a8b7b" },
  ["@field"] = { fg = "#9a8b7b" },
  Property = { fg = "#8a9a7b" },
  ["@property"] = { fg = "#8a9a7b" },

  Constant = { fg = "#8a9a8b" },
  ["@constant"] = { fg = "#8a9a8b" },
  ["@constant.builtin"] = { fg = "#8a9a8b" },
  Boolean = { fg = "#9a7b6f" },
  ["@boolean"] = { fg = "#9a7b6f" },
  Number = { fg = "#b8956a" },
  ["@number"] = { fg = "#b8956a" },
  Float = { fg = "#b8956a" },

  Special = { fg = "#987f87" },
  ["@tag"] = { fg = "#7a8b9a" },
  Tag = { fg = "#7a8b9a" },
  ["@attribute"] = { fg = "#8f8780" },
  ["@attribute.builtin"] = { fg = "#8f8780" },
  ["@constructor"] = { fg = "#8a9a8b" },
  ["@operator"] = { fg = "#8b8580" },
  Operator = { fg = "#8b8580" },
  Delimiter = { fg = "#987f87" },
  ["@punctuation.bracket"] = { fg = "#987f87" },
  ["@punctuation.delimiter"] = { fg = "#6b8580" },
  ["@punctuation.special"] = { fg = "#987f87" },

  -- Titles and misc text
  Title = { fg = "#c9a66b" },
  Directory = { fg = "#7a8590" },
  Question = { fg = "#9aa0a6" },
  MoreMsg = { fg = "#9f8c5b" },
  ModeMsg = { fg = "#9f8c5b" },
  Search = { fg = "#121415", bg = "#c9a66b" },
  IncSearch = { fg = "#121415", bg = "#b55a5a" },
  CurSearch = { link = "IncSearch" },
  Substitute = { link = "Search" },
  Underlined = { fg = "#7f9bb3", underline = true },
  Todo = { fg = "#181a1b", bg = "#9f8c5b", italic = true },
  ["@text.todo"] = { fg = "#181a1b", bg = "#9f8c5b", italic = true },

  -- Cursor and selection
  Cursor = { fg = "#121415", bg = "#d8dee9" },
  CursorLine = { bg = "#1d1f21" },
  CursorColumn = { bg = "#1d1f21" },
  CursorLineNr = { fg = "#b9a66f", bg = "#1d1f21" },
  Visual = { bg = "#30343a" },
  VisualNOS = { bg = "#2d2225" },
  MatchParen = { bg = "#282a2e", bold = true },

  -- Line numbers and gutters
  LineNr = { fg = "#5a5d63" },
  LineNrAbove = { fg = "#5a5d63" },
  LineNrBelow = { fg = "#5a5d63" },
  SignColumn = { bg = "#181a1b" },
  FoldColumn = { fg = "#5a5d63", bg = "#181a1b" },
  Folded = { fg = "#5a5d63", bg = "#181a1b" },
  Whitespace = { fg = "#373b41" },
  NonText = { fg = "#373b41" },
  SpecialKey = { fg = "#4c566a" },
  Conceal = { fg = "#7f9bb3" },
  WinSeparator = { fg = "#373b41", bg = "#181a1b" },
  VertSplit = { fg = "#373b41", bg = "#181a1b" },

  -- Status and tabs
  StatusLine = { fg = "#9aa0a6", bg = "#181a1b" },
  StatusLineNC = { fg = "#6b6863", bg = "#181a1b" },
  TabLine = { fg = "#9aa0a6", bg = "#181a1b" },
  TabLineSel = { fg = "#d8dee9", bg = "#282a2e" },
  TabLineFill = { fg = "#4c566a", bg = "#181a1b" },
  WinBar = { fg = "#9aa0a6", bg = "#181a1b" },
  WinBarNC = { fg = "#bdae93", bg = "#1d1f21" },

  -- Popup/menu
  Pmenu = { fg = "#9aa0a6", bg = "#181a1b" },
  PmenuSel = { fg = "#d8dee9", bg = "#282a2e" },
  PmenuSbar = { bg = "#181a1b" },
  PmenuThumb = { bg = "#373b41" },
  PmenuBorder = { fg = "#282a2e", bg = "#181a1b" },

  -- Floating windows
  NormalFloat = { fg = "#ebdbb2", bg = "#1d1f21" },
  FloatBorder = { fg = "#373b41", bg = "#1d1f21" },
  FloatTitle = { fg = "#c9a66b", bg = "#1d1f21" },
  FloatFooter = { fg = "#c9a66b", bg = "#1d1f21" },

  -- Diagnostics
  ErrorMsg = { fg = "#1d1f21", bg = "#a86a63" },
  WarningMsg = { fg = "#b59a78" },
  DiagnosticError = { fg = "#a86a63" },
  DiagnosticWarn = { fg = "#b59a78" },
  DiagnosticInfo = { fg = "#7f8c94" },
  DiagnosticHint = { fg = "#8a9684" },
  DiagnosticOk = { fg = "#8a9a8b" },
  DiagnosticFloatingError = { fg = "#a86a63" },
  DiagnosticFloatingWarn = { fg = "#b59a78" },
  DiagnosticFloatingInfo = { fg = "#7f8c94" },
  DiagnosticFloatingHint = { fg = "#8a9684" },
  DiagnosticFloatingOk = { fg = "#8a9a8b" },
  DiagnosticUnderlineError = { sp = "#a86a63", undercurl = true },
  DiagnosticUnderlineWarn = { sp = "#b59a78", undercurl = true },
  DiagnosticUnderlineInfo = { sp = "#7f8c94", undercurl = true },
  DiagnosticUnderlineHint = { sp = "#8a9684", undercurl = true },
  DiagnosticUnderlineOk = { sp = "#8a9a8b", undercurl = true },

  -- Diff
  DiffAdd = { fg = "#121415", bg = "#8a9a7b" },
  DiffChange = { fg = "#121415", bg = "#8a8590" },
  DiffDelete = { fg = "#121415", bg = "#a67b7b" },
  DiffText = { fg = "#121415", bg = "#c9a66b" },

  -- Trees, picker, and misc plugin UI
  NeoTreeNormal = { fg = "#d8dee9", bg = "#0d0f10" },
  NeoTreeNormalNC = { fg = "#c8d0e0", bg = "#0d0f10" },
  NeoTreeWinSeparator = { fg = "#1d1f21", bg = "NONE" },
  NeoTreeDirectoryName = { fg = "#286770" },
  NeoTreeDirectoryIcon = { fg = "#ce9b0f" },
  NeoTreeFileName = { fg = "#d8dee9" },
  NeoTreeGitModified = { fg = "#8a9a8b" },
  NeoTreeGitUntracked = { fg = "#cc7917" },

  TelescopeBorder = { fg = "#373b41", bg = "#1d1f21" },
  TelescopeNormal = { fg = "#d8dee9", bg = "#1d1f21" },
  TelescopeSelection = { bg = "#30343a" },
  TelescopeSelectionCaret = { fg = "#b86f6f", bg = "#30343a" },
  TelescopeMatching = { fg = "#a97f5e" },

  NoiceCmdlinePopupBorder = { fg = "#83a598" },
  NoiceCmdlinePopupBorderSearch = { fg = "#fabd2f" },

  WhichKeyBorder = { fg = "#373b41" },
  WhichKeyNormal = { fg = "#d8dee9", bg = "#1d1f21" },

  MiniStatuslineModeNormal = { fg = "#181a1b", bg = "#ebdbb2" },
  MiniStatuslineModeInsert = { fg = "#181a1b", bg = "#83a598" },
  MiniStatuslineModeVisual = { fg = "#181a1b", bg = "#b8bb26" },
  MiniStatuslineModeReplace = { fg = "#181a1b", bg = "#fb4934" },
  MiniStatuslineModeCommand = { fg = "#181a1b", bg = "#fabd2f" },
  MiniStatuslineModeOther = { fg = "#181a1b", bg = "#8ec07c" },

  MiniHipatternsTodo = { fg = "#181a1b", bg = "#8ec07c" },
  MiniHipatternsNote = { fg = "#181a1b", bg = "#83a598" },
  MiniHipatternsHack = { fg = "#181a1b", bg = "#fabd2f" },
  MiniHipatternsFixme = { fg = "#181a1b", bg = "#fb4934" },

  -- LSP / semantic
  LspReferenceRead = { fg = "#9f8c5b", bg = "#1d1f21" },
  LspReferenceText = { fg = "#9f8c5b", bg = "#1d1f21" },
  LspReferenceWrite = { fg = "#c29a77", bg = "#1d1f21" },
  LspSignatureActiveParameter = { fg = "#121415", bg = "#9f8c5b" },
  LspInlayHint = { fg = "#6b6863" },

  -- Link-like and markdown-ish
  MarkdownLinkText = { fg = "#6b6863", underline = true },
  MarkupLink = { fg = "#6b6863", underline = true },

  -- Keep the rest subtle
  QuickFixLine = { bg = "#282a2e" },
},

--  overrides = {
--      GruvboxRed = { fg = "#b86f6f" },
--   GruvboxGreen = { fg = "#729073" },
--   GruvboxYellow = { fg = "#9f8c5b" },
--   GruvboxBlue = { fg = "#6f8698" },
--   GruvboxPurple = { fg = "#7f6f97" },
--   GruvboxAqua = { fg = "#678b86" },
--   GruvboxOrange = { fg = "#a97f5e" },
--   -- Comments: dusty earth gray, slightly desaturated
--   ["@comment"] = { fg = "#6b6863", italic = true },
--   ["Comment"] = { fg = "#6b6863", italic = true },
--
--   -- Strings: olive/pastel green instead of bright green
--   ["@string"] = { fg = "#879050" },
--   ["String"] = { fg = "#878057" },
--
--   -- Keywords: pale brick red, muted
--   ["@keyword"] = { fg = "#a86a63" },
--   ["Keyword"] = { fg = "#a86a63" },
--   ["@keyword.conditional"] = { fg = "#a86a63" },
--
--   -- Functions: warm dusty brown/orange
--   ["@function"] = { fg = "#c2a073" },
--   ["Function"] = { fg = "#c2a073" },
--
--   -- Types: muted warm taupe/beige
--   ["@type"] = { fg = "#a89688" },
--   ["Type"] = { fg = "#a89688" },
--
--   -- Numbers: soft desaturated orange
--   ["@number"] = { fg = "#b8956a" },
--   ["Number"] = { fg = "#b8956a" },
--
--   -- Booleans: muted warm brown
--   ["@boolean"] = { fg = "#9a7b6f" },
--   ["Boolean"] = { fg = "#9a7b6f" },
--
--   -- Operators: desaturated warm gray
--   ["@operator"] = { fg = "#8b8580" },
--   ["Operator"] = { fg = "#8b8580" },
--
--   -- Special/Tags: muted dusty blue
--   ["@tag"] = { fg = "#7a8b9a" },
--   ["Tag"] = { fg = "#7a8b9a" },
--
--   -- Defaults: muted slate gray
--   ["@variable"] = { fg = "#a39a91" },
--   ["Variable"] = { fg = "#a39a91" },
--
--   -- Constants: soft desaturated teal
--   ["@constant"] = { fg = "#8a9a8b" },
--   ["Constant"] = { fg = "#8a9a8b" },
--
--   -- Exceptions: muted warm red
--   ["@exception"] = { fg = "#a67b7b" },
--   ["Exception"] = { fg = "#a67b7b" },
--
--   -- Parameters: dusty lavender gray
--   ["@parameter"] = { fg = "#a1958a" },
--   ["Parameter"] = { fg = "#a1958a" },
--
--   -- Methods: warm muted copper
--   ["@method"] = { fg = "#c4a88b" },
--   ["Method"] = { fg = "#c4a88b" },
--
--   -- Fields: soft desaturated brown
--   ["@field"] = { fg = "#9a8b7b" },
--   ["Field"] = { fg = "#9a8b7b" },
--
--   -- Properties: muted sage green
--   ["@property"] = { fg = "#8a9a7b" },
--   ["Property"] = { fg = "#8a9a7b" },
--
--   -- Import: dusty cool gray
--   ["@include"] = { fg = "#8f8780" },
--   ["Include"] = { fg = "#8f8780" },
--
--   -- Definitions: muted warm gray
--   ["@define"] = { fg = "#8f8a85" },
--   ["Define"] = { fg = "#8f8a85" },
--
--   -- Macros: soft desaturated purple
--   ["@macro"] = { fg = "#8a7b9a" },
--   ["Macro"] = { fg = "#8a7b9a" },
--
--   -- Title: warm muted orange
--   ["Title"] = { fg = "#c9a66b" },
--
--   -- Directory: dusty blue-gray
--   ["Directory"] = { fg = "#7a8590" },
--
--   -- Statement: pale brick
--   ["Statement"] = { fg = "#b55a5a" },
--
--   -- Work: muted warm tone
--   ["Work"] = { fg = "#c9a66b" },
--
--   -- Cursor: keep bright for visibility
--   ["Cursor"] = { fg = "#121415", bg = "#d8dee9" },
--   ["CursorLine"] = { bg = "#1d1f21" },
--   ["CursorColumn"] = { bg = "#1d1f21" },
--
--   -- UI elements: subtle muted tones
--   ["LineNr"] = { fg = "#5a5d63" },
--   ["LineNrActive"] = { fg = "#9aa0a6" },
--   ["VertSplit"] = { fg = "#282a2e" },
--   ["FoldColumn"] = { fg = "#5a5d63" },
--   ["Folded"] = { fg = "#5a5d63", bg = "#181a1b" },
--   ["SignColumn"] = { fg = "#5a5d63" },
--
--   -- Status lines: muted dark
--   ["StatusLine"] = { fg = "#9aa0a6", bg = "#181a1b" },
--   ["StatusLineNC"] = { fg = "#6b6863", bg = "#181a1b" },
--   ["TabLine"] = { fg = "#9aa0a6", bg = "#181a1b" },
--   ["TabLineSel"] = { fg = "#d8dee9", bg = "#282a2e" },
--
--   -- Search/highlights: softened
--   ["Search"] = { fg = "#121415", bg = "#c9a66b" },
--   ["IncSearch"] = { fg = "#121415", bg = "#b55a5a" },
--   ["MatchParen"] = { bg = "#282a2e", bold = true },
--
--   -- Diff: muted colors
--   ["DiffAdd"] = { fg = "#121415", bg = "#8a9a7b" },
--   ["DiffChange"] = { fg = "#121415", bg = "#8a8590" },
--   ["DiffDelete"] = { fg = "#121415", bg = "#a67b7b" },
--   ["DiffText"] = { fg = "#121415", bg = "#c9a66b" },
--
--   -- Alerts: softened
--   ["InfoMsg"] = { fg = "#7a8b9a" },
--   ["Question"] = { fg = "#9aa0a6" },
--
--   -- Visual: muted
--   ["Visual"] = { bg = "#3d2d31" },
--   ["VisualNOS"] = { bg = "#3d1a1e" },
--
--   -- Quickfix: subtle
--   ["QuickfixLine"] = { bg = "#282a2e" },
--
--   -- Pmenu: dusty
--   ["Pmenu"] = { fg = "#9aa0a6", bg = "#181a1b" },
--   ["PmenuSel"] = { fg = "#d8dee9", bg = "#282a2e" },
--   ["PmenuSbar"] = { bg = "#181a1b" },
--   ["PmenuThumb"] = { bg = "#373b41" },
--
--   -- Whitespace: very subtle
--   ["Whitespace"] = { fg = "#373b41" },
--   ["@punctuation.bracket"] = { fg = "#987f87" },
-- ["@punctuation.delimiter"] = { fg = "#6b8580" },
-- ["@punctuation.special"] = { fg = "#987f87" },
-- ["@punctuation.braces"] = { fg = "#987f87"},["Delimiter"] = { fg = "#987f87" },
-- ["Special"] = { fg = "#987f87" },
--
--
--
-- ["ErrorMsg"] = { fg = "#1d1f21", bg = "#a86a63" },      -- muted brick
-- ["WarningMsg"] = { fg = "#b59a78" },    -- aged brass
--
-- ["DiagnosticError"] = { fg = "#a86a63" },
-- ["DiagnosticWarn"] = { fg = "#b59a78" },
-- ["DiagnosticInfo"] = { fg = "#7f8c94" },
-- ["DiagnosticHint"] = { fg = "#8a9684" },
--
--
--     -- 1. Force the file tree backgrounds to perfectly match your root dark/muted palette
--     NeoTreeNormal   = { fg = "#d8dee9", bg = "#0d0f10" }, -- Uses your custom dark palette values
--     NeoTreeNormalNC = { fg = "#c8d0e0", bg = "#0d0f10" }, -- Keeps background locked when focusing code windows
--
--     -- 2. Blend the vertical layout line seamlessly
--     NeoTreeWinSeparator = { fg = "#1d1f21", bg = "NONE" }, 
--
--     -- 3. Mute or adjust specific directory components
--     NeoTreeDirectoryName = { fg = "#286770" }, -- Classic Gruvbox blue made flat
--     NeoTreeDirectoryIcon = { fg = "#ce9b0f" }, -- Keep the iconic yellow but bounded
--     NeoTreeFileName      = { fg = "#d8dee9" }, -- Clean primary font color
--
--     -- 4. Keep git modification trackers subtle
--     NeoTreeGitModified   = { fg = "#8a9a8b" }, -- Soft olive instead of glaring neon green
--     NeoTreeGitUntracked  = { fg = "#cc7917" }, 
--  },

  dim_inactive = false,
  transparent_mode = false,
})


vim.cmd.colorscheme("gruvbox")
