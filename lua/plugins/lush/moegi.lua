local lush = require "lush"

local utils = require "plugins.lush.utils"

local lch = utils.lch
local hex = utils.hex_as_lch

local buf_fg = hex "#e0e0e0"
local buf_bg = hex "#202020"

local ui_fg = hex "#999999"
local ui_hi_fg = buf_fg.da(4)
local ui_bg = buf_bg.da(4)

local buf_hi_bg = buf_bg.li(8)

local p = {}

---@alias HueName "red"|"green"|"yellow"|"blue"|"purple"|"cyan"|"orange"

---@type HueName[]
local hue_name_list = { "red", "green", "yellow", "blue", "purple", "cyan", "orange" }

local pal = {
  hex "#e47474", -- lch(61, 82, 12)
  hex "#74ccaa", -- lch(75, 44, 155)
  hex "#f6c177", -- lch(81, 67, 53)
  hex "#a0a5d6", -- lch(68, 41, 262)
  hex "#ed9cc2", -- lch(73, 50, 340)
  hex "#5fb5be", -- lch(68, 40, 202)
  hex "#f3a580", -- lch(74, 66, 31)
}

for index, hue_name in ipairs(hue_name_list) do
  p[hue_name] = pal[index]
  p["bright_" .. hue_name] = pal[index].mod_lc { 8, 5 }
  p["based_" .. hue_name] = pal[index].set_lc { 64, 35 }
  p["dark_" .. hue_name] = pal[index].set_lc { 54, 25 }
  p["faded_" .. hue_name] = pal[index].set_lc { 36, 13 }
  p["highlightbg_" .. hue_name] = pal[index].set_lc { 94, 35 }
end

p.black = hex "#202020"
p.dark_gray = hex "#303030"
p.gray = hex "#999999"
p.light_gray = hex "#c0c0c0"
p.white = hex "#e0e0e0"

for i = 0, 15 do
  vim.g["terminal_color_" .. i] = nil
end

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local s = injected_functions.sym
  return {
    MoegiPale { fg = p.blue },

    FadedRed { fg = p.faded_red },
    FadedGreen { fg = p.faded_green },
    FadedYellow { fg = p.faded_yellow },
    FadedBlue { fg = p.faded_blue },
    FadedPurple { fg = p.faded_purple },
    FadedCyan { fg = p.faded_cyan },
    FadedOrange { fg = p.faded_orange },

    DarkRed { fg = p.dark_red },
    DarkGreen { fg = p.dark_green },
    DarkYellow { fg = p.dark_yellow },
    DarkBlue { fg = p.dark_blue },
    DarkPurple { fg = p.dark_purple },
    DarkCyan { fg = p.dark_cyan },
    DarkOrange { fg = p.dark_orange },

    BasedRed { fg = p.based_red },
    BasedGreen { fg = p.based_green },
    BasedYellow { fg = p.based_yellow },
    BasedBlue { fg = p.based_blue },
    BasedPurple { fg = p.based_purple },
    BasedCyan { fg = p.based_cyan },
    BasedOrange { fg = p.based_orange },

    MoegiRed { fg = p.red },
    MoegiGreen { fg = p.green },
    MoegiYellow { fg = p.yellow },
    MoegiBlue { fg = p.blue },
    MoegiPurple { fg = p.purple },
    MoegiCyan { fg = p.cyan },
    MoegiOrange { fg = p.orange },

    BrightRed { fg = p.bright_red },
    BrightGreen { fg = p.bright_green },
    BrightYellow { fg = p.bright_yellow },
    BrightBlue { fg = p.bright_blue },
    BrightPurple { fg = p.bright_purple },
    BrightCyan { fg = p.bright_cyan },
    BrightOrange { fg = p.bright_orange },

    BrightRedHighlight { gui = "reverse", fg = p.bright_red },
    BrightGreenHighlight { gui = "reverse", fg = p.bright_green },
    BrightYellowHighlight { gui = "reverse", fg = p.bright_yellow },
    RedHighlight { gui = "bold", bg = p.red.mix(buf_bg, 0.5) },

    GreenHighlight { gui = "bold", bg = p.green.mix(buf_bg, 0.5) },
    YellowHighlight { gui = "bold", bg = p.yellow.mix(buf_bg, 0.5) },

    WeakRedHighlight { bg = p.based_red.mix(buf_bg, 0.5) },
    WeakGreenHighlight { bg = p.based_green.mix(buf_bg, 0.5) },
    WeakYellowHighlight { bg = p.based_yellow.mix(buf_bg, 0.5) },
    WeakBlueHighlight { bg = p.based_blue.mix(buf_bg, 0.5) },
    WeakPurpleHighlight { bg = p.based_purple.mix(buf_bg, 0.5) },
    WeakCyanHighlight { bg = p.based_cyan.mix(buf_bg, 0.5) },
    WeakOrangeHighlight { bg = p.based_orange.mix(buf_bg, 0.5) },

    RedOverlay { bg = p.faded_red.mix(buf_bg, 0.5) },
    GreenOverlay { bg = p.faded_green.mix(buf_bg, 0.5) },
    YellowOverlay { bg = p.faded_yellow.mix(buf_bg, 0.5) },
    BlueOverlay { bg = p.faded_blue.mix(buf_bg, 0.5) },
    PurpleOverlay { bg = p.faded_purple.mix(buf_bg, 0.5) },
    CyanOverlay { bg = p.faded_cyan.mix(buf_bg, 0.5) },
    OrangeOverlay { bg = p.faded_orange.mix(buf_bg, 0.5) },

    RedUnderline { gui = "underline", sp = p.red },
    GreenUnderline { gui = "underline", sp = p.green },
    YellowUnderline { gui = "underline", sp = p.yellow },
    BlueUnderline { gui = "underline", sp = p.blue },
    PurpleUnderline { gui = "underline", sp = p.purple },
    CyanUnderline { gui = "underline", sp = p.cyan },
    OrangeUnderline { gui = "underline", sp = p.orange },

    RedUndercurl { gui = "undercurl", sp = p.red },
    GreenUndercurl { gui = "undercurl", sp = p.green },
    YellowUndercurl { gui = "undercurl", sp = p.yellow },
    BlueUndercurl { gui = "undercurl", sp = p.blue },
    PurpleUndercurl { gui = "undercurl", sp = p.purple },
    CyanUndercurl { gui = "undercurl", sp = p.cyan },
    OrangeUndercurl { gui = "undercurl", sp = p.orange },

    --- Vim Ui Vars
    -- ColorColumn    { }, -- Columns set with 'colorcolumn'
    -- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor { gui = "reverse" }, -- Character under the cursor
    -- CurSearch      { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
    -- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine { bg = buf_hi_bg }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory { fg = p.blue }, -- Directory names (and other special names in listings)
    DiffAdd { WeakGreenHighlight }, -- Diff mode: Added line |diff.txt|
    DiffChange { YellowHighlight }, -- Diff mode: Changed line |diff.txt|
    DiffDelete { RedHighlight }, -- Diff mode: Deleted line |diff.txt|
    DiffText { GreenHighlight }, -- Diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor     { }, -- Cursor in a focused terminal
    -- TermCursorNC   { }, -- Cursor in an unfocused terminal
    -- ErrorMsg       { }, -- Error messages on the command line
    -- VertSplit      { }, -- Column separating vertically split windows
    Folded { fg = ui_hi_fg, bg = ui_bg }, -- Line used for closed folds
    -- FoldColumn {}, -- 'foldcolumn'
    -- SignColumn     { }, -- Column where |signs| are displayed
    IncSearch { BrightYellowHighlight }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute { BrightRedHighlight }, -- |:substitute| replacement text highlighting
    LineNr { fg = ui_fg }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    -- LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr { fg = p.yellow, bg = buf_hi_bg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    -- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen { gui = "bold", bg = buf_hi_bg }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg        { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea        { }, -- Area for messages and cmdline
    -- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg        { }, -- |more-prompt|
    -- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal { fg = buf_fg, bg = buf_bg }, -- Normal text
    NormalFloat { fg = ui_fg, bg = ui_bg }, -- Normal text in floating windows.
    -- FloatBorder    { }, -- Border of floating windows.
    -- FloatTitle     { }, -- Title of floating windows.
    -- NormalNC       { }, -- normal text in non-current windows
    Pmenu { bg = ui_bg }, -- Popup menu: Normal item.
    -- PmenuSel       { }, -- Popup menu: Selected item.
    -- PmenuKind      { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
    -- PmenuSbar      { }, -- Popup menu: Scrollbar.
    -- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
    -- Question       { }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    -- Search         { }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    -- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad { RedUndercurl }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap { YellowUndercurl }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal { GreenUndercurl }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare { CyanUndercurl }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine { fg = ui_fg, bg = ui_bg }, -- Status line of current window
    -- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- TabLine        { }, -- Tab pages line, not active tab page label
    -- TabLineFill    { }, -- Tab pages line, where there are no labels
    -- TabLineSel     { }, -- Tab pages line, active tab page label
    -- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
    -- Visual         { }, -- Visual mode selection
    -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg     { }, -- Warning messages
    -- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- Winseparator   {  , -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    -- WildMenu       { }, -- Current match in 'wildmenu' completion
    WinBar { fg = ui_fg, bg = buf_bg }, -- Window bar of current window
    WinBarNC { WinBar }, -- Window bar of not-current windows

    -- Basic Syntax
    Constant { gui = "bold", fg = p.blue }, -- (*) Any constant
    String { gui = "italic", fg = p.green }, --   A string constant: "this is a string"
    Character { gui = "Italic underline", fg = p.green }, --   A character constant: 'c', '\n'
    Number { gui = "bold italic", fg = p.yellow }, --   A number constant: 234, 0xff
    Boolean { Number }, --   A boolean constant: TRUE, false
    Float { Number }, --   A floating point constant: 2.3e10

    Identifier { fg = p.blue }, -- (*) Any variable name
    Function { fg = p.cyan }, --   Function name (also: methods for classes)

    Statement { gui = "bold italic", fg = p.purple }, -- (*) Any statement
    -- Conditional    { }, --   if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --   case, default, etc.
    Operator { fg = p.purple }, --   "sizeof", "+", "*", etc.
    -- Keyword        { }, --   any other keyword
    -- Exception      { }, --   try, catch, throw

    PreProc { fg = p.cyan }, -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type { fg = p.orange }, -- (*) int, long, char, etc.
    -- StorageClass   { }, --   static, register, volatile, etc.
    -- Structure      { }, --   struct, union, enum, etc.
    -- Typedef        { }, --   A typedef

    Special { fg = p.cyan }, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    Delimiter { MoegiOrange }, --   Character that needs attention
    -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    -- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error { fg = ui_hi_fg, bg = p.red }, -- Any erroneous construct
    -- Todo           { }, -- Anything that needs extra attention; mostly the keyword

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    LspInlayHint { gui = "bold italic", fg = ui_fg, bg = buf_hi_bg },

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError { MoegiRed }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn { MoegiYellow }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo { MoegiCyan }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint { MoegiBlue }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk { MoegiGreen }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    DiagnosticUnderlineError { RedUndercurl }, -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn { OrangeUndercurl }, -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo { CyanUndercurl }, -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint { BlueUndercurl }, -- Used to underline "Hint" diagnostics.
    DiagnosticUnderlineOk { GreenUndercurl }, -- Used to underline "Ok" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    NotifyERRORIcon { MoegiRed },
    NotifyWARNIcon { MoegiYellow },
    NotifyINFOIcon { MoegiCyan },
    NotifyLOGIcon { MoegiBlue },
    NotifyTRACEIcon { MoegiPurple },

    NotifyERRORTitle { MoegiRed },
    NotifyWARNTitle { MoegiYellow },
    NotifyINFOTitle { MoegiCyan },
    NotifyLOGTitle { MoegiBlue },
    NotifyTRACETitle { MoegiPurple },

    NotifyERRORBorder { gui = "bold", fg = p.red },
    NotifyWARNBorder { gui = "bold", fg = p.yellow },
    NotifyINFOBorder { gui = "bold", fg = p.cyan },
    NotifyLOGBorder { gui = "bold", fg = p.blue },
    NotifyTRACEBorder { gui = "bold", fg = p.purple },

    DashboardIcon { fg = p.light_gray },
    DashboardDesc { fg = p.light_gray },
    DashboardKey { fg = p.light_gray },
    DashboardFooter { gui = "italic", fg = p.based_green },

    s "@variable" { Identifier },
    s "@type.builtin" { Type },
  }
end)

return theme
