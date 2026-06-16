vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim"
})

-- Default options:
require("gruvbox").setup({
  terminal_colors = false, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
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
  -- Comments: dusty earth gray, slightly desaturated
  ["@comment"] = { fg = "#6b6863", italic = true },
  ["Comment"] = { fg = "#6b6863", italic = true },
  
  -- Strings: olive/pastel green instead of bright green
  ["@string"] = { fg = "#879050" },
  ["String"] = { fg = "#878057" },
  
  -- Keywords: pale brick red, muted
  ["@keyword"] = { fg = "#a86a63" },
  ["Keyword"] = { fg = "#a86a63" },
  ["@keyword.conditional"] = { fg = "#a86a63" },
  
  -- Functions: warm dusty brown/orange
  ["@function"] = { fg = "#c2a073" },
  ["Function"] = { fg = "#c2a073" },
  
  -- Types: muted warm taupe/beige
  ["@type"] = { fg = "#a89688" },
  ["Type"] = { fg = "#a89688" },
  
  -- Numbers: soft desaturated orange
  ["@number"] = { fg = "#b8956a" },
  ["Number"] = { fg = "#b8956a" },
  
  -- Booleans: muted warm brown
  ["@boolean"] = { fg = "#9a7b6f" },
  ["Boolean"] = { fg = "#9a7b6f" },
  
  -- Operators: desaturated warm gray
  ["@operator"] = { fg = "#8b8580" },
  ["Operator"] = { fg = "#8b8580" },
  
  -- Special/Tags: muted dusty blue
  ["@tag"] = { fg = "#7a8b9a" },
  ["Tag"] = { fg = "#7a8b9a" },
  
  -- Defaults: muted slate gray
  ["@variable"] = { fg = "#a39a91" },
  ["Variable"] = { fg = "#a39a91" },
  
  -- Constants: soft desaturated teal
  ["@constant"] = { fg = "#8a9a8b" },
  ["Constant"] = { fg = "#8a9a8b" },
  
  -- Exceptions: muted warm red
  ["@exception"] = { fg = "#a67b7b" },
  ["Exception"] = { fg = "#a67b7b" },
  
  -- Parameters: dusty lavender gray
  ["@parameter"] = { fg = "#a1958a" },
  ["Parameter"] = { fg = "#a1958a" },
  
  -- Methods: warm muted copper
  ["@method"] = { fg = "#c4a88b" },
  ["Method"] = { fg = "#c4a88b" },
  
  -- Fields: soft desaturated brown
  ["@field"] = { fg = "#9a8b7b" },
  ["Field"] = { fg = "#9a8b7b" },
  
  -- Properties: muted sage green
  ["@property"] = { fg = "#8a9a7b" },
  ["Property"] = { fg = "#8a9a7b" },
  
  -- Import: dusty cool gray
  ["@include"] = { fg = "#8f8780" },
  ["Include"] = { fg = "#8f8780" },
  
  -- Definitions: muted warm gray
  ["@define"] = { fg = "#8f8a85" },
  ["Define"] = { fg = "#8f8a85" },
  
  -- Macros: soft desaturated purple
  ["@macro"] = { fg = "#8a7b9a" },
  ["Macro"] = { fg = "#8a7b9a" },
  
  -- Title: warm muted orange
  ["Title"] = { fg = "#c9a66b" },
  
  -- Directory: dusty blue-gray
  ["Directory"] = { fg = "#7a8590" },
  
  -- Statement: pale brick
  ["Statement"] = { fg = "#b55a5a" },
  
  -- Work: muted warm tone
  ["Work"] = { fg = "#c9a66b" },
  
  -- Cursor: keep bright for visibility
  ["Cursor"] = { fg = "#121415", bg = "#d8dee9" },
  ["CursorLine"] = { bg = "#1d1f21" },
  ["CursorColumn"] = { bg = "#1d1f21" },
  
  -- UI elements: subtle muted tones
  ["LineNr"] = { fg = "#5a5d63" },
  ["LineNrActive"] = { fg = "#9aa0a6" },
  ["VertSplit"] = { fg = "#282a2e" },
  ["FoldColumn"] = { fg = "#5a5d63" },
  ["Folded"] = { fg = "#5a5d63", bg = "#181a1b" },
  ["SignColumn"] = { fg = "#5a5d63" },
  
  -- Status lines: muted dark
  ["StatusLine"] = { fg = "#9aa0a6", bg = "#181a1b" },
  ["StatusLineNC"] = { fg = "#6b6863", bg = "#181a1b" },
  ["TabLine"] = { fg = "#9aa0a6", bg = "#181a1b" },
  ["TabLineSel"] = { fg = "#d8dee9", bg = "#282a2e" },
  
  -- Search/highlights: softened
  ["Search"] = { fg = "#121415", bg = "#c9a66b" },
  ["IncSearch"] = { fg = "#121415", bg = "#b55a5a" },
  ["MatchParen"] = { bg = "#282a2e", bold = true },
  
  -- Diff: muted colors
  ["DiffAdd"] = { fg = "#121415", bg = "#8a9a7b" },
  ["DiffChange"] = { fg = "#121415", bg = "#8a8590" },
  ["DiffDelete"] = { fg = "#121415", bg = "#a67b7b" },
  ["DiffText"] = { fg = "#121415", bg = "#c9a66b" },
  
  -- Alerts: softened
  ["InfoMsg"] = { fg = "#7a8b9a" },
  ["Question"] = { fg = "#9aa0a6" },
  
  -- Visual: muted
  ["Visual"] = { bg = "#3d2d31" },
  ["VisualNOS"] = { bg = "#3d1a1e" },
  
  -- Quickfix: subtle
  ["QuickfixLine"] = { bg = "#282a2e" },
  
  -- Pmenu: dusty
  ["Pmenu"] = { fg = "#9aa0a6", bg = "#181a1b" },
  ["PmenuSel"] = { fg = "#d8dee9", bg = "#282a2e" },
  ["PmenuSbar"] = { bg = "#181a1b" },
  ["PmenuThumb"] = { bg = "#373b41" },
  
  -- Whitespace: very subtle
  ["Whitespace"] = { fg = "#373b41" },
  ["@punctuation.bracket"] = { fg = "#987f87" },
["@punctuation.delimiter"] = { fg = "#6b8580" },
["@punctuation.special"] = { fg = "#987f87" },
["@punctuation.braces"] = { fg = "#987f87"},["Delimiter"] = { fg = "#987f87" },
["Special"] = { fg = "#987f87" },



["ErrorMsg"] = { fg = "#a86a63" },      -- muted brick
["WarningMsg"] = { fg = "#b59a78" },    -- aged brass

["DiagnosticError"] = { fg = "#a86a63" },
["DiagnosticWarn"] = { fg = "#b59a78" },
["DiagnosticInfo"] = { fg = "#7f8c94" },
["DiagnosticHint"] = { fg = "#8a9684" },


    -- 1. Force the file tree backgrounds to perfectly match your root dark/muted palette
    NeoTreeNormal   = { fg = "#d8dee9", bg = "#0d0f10" }, -- Uses your custom dark palette values
    NeoTreeNormalNC = { fg = "#c8d0e0", bg = "#0d0f10" }, -- Keeps background locked when focusing code windows
    
    -- 2. Blend the vertical layout line seamlessly
    NeoTreeWinSeparator = { fg = "#1d1f21", bg = "NONE" }, 

    -- 3. Mute or adjust specific directory components
    NeoTreeDirectoryName = { fg = "#286770" }, -- Classic Gruvbox blue made flat
    NeoTreeDirectoryIcon = { fg = "#ce9b0f" }, -- Keep the iconic yellow but bounded
    NeoTreeFileName      = { fg = "#d8dee9" }, -- Clean primary font color
    
    -- 4. Keep git modification trackers subtle
    NeoTreeGitModified   = { fg = "#8a9a8b" }, -- Soft olive instead of glaring neon green
    NeoTreeGitUntracked  = { fg = "#cc7917" }, 
},

  dim_inactive = false,
  transparent_mode = false,
})

vim.cmd("colorscheme gruvbox")
