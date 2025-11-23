" Gruvbox Dark Hard - Custom colorscheme based on terminal color palette
" This colorscheme uses a very dark, slightly warm grey background with muted colors

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "gruvbox-dark-hard"

" ANSI 16-Color Palette
" Normal Colors (0-7)
let s:black      = "#1d2021"  " Very dark grey (Color 0)
let s:red        = "#cc241d"  " Muted primary red (Color 1)
let s:green      = "#98971a"  " Olive/dark-grass green (Color 2)
let s:yellow     = "#d79921"  " Ochre/dark goldenrod yellow (Color 3)
let s:blue       = "#458588"  " Muted medium-dark blue (Color 4)
let s:magenta    = "#b16286"  " Muted purplish-pink/dark magenta (Color 5)
let s:cyan       = "#689d6a"  " Muted teal/greyish-cyan (Color 6)
let s:white      = "#a89984"  " Light grey (Color 7)

" Bright Colors (8-15)
let s:bright_black   = "#928374"  " Medium grey (Color 8)
let s:bright_red      = "#fb4934"  " Bright clear red (Color 9)
let s:bright_green    = "#b8bb26"  " Bright vivid green (Color 10)
let s:bright_yellow   = "#fabd2f"  " Bright vivid yellow (Color 11)
let s:bright_blue     = "#83a598"  " Bright clear blue (Color 12)
let s:bright_magenta  = "#d3869b"  " Bright vivid pink/magenta (Color 13)
let s:bright_cyan     = "#8ec07c"  " Bright vivid cyan (Color 14)
let s:bright_white    = "#fbf1c7"  " Bright full white (Color 15)

" Core Theme Colors
let s:bg0     = "#1d2021"  " Default background - very dark, slightly warm grey
let s:bg1     = "#282828"  " Slightly lighter background
let s:bg2     = "#3c3836"  " Medium-dark grey (for selection)
let s:bg3     = "#504945"  " Lighter medium-dark grey
let s:bg4     = "#665c54"  " Even lighter grey
let s:fg0     = s:bright_white   " Default foreground - light grey
let s:fg1     = s:white          " Secondary foreground
let s:fg2     = s:bright_black   " Tertiary foreground
let s:fg3     = s:black          " Darkest foreground

" Terminal colors
let g:terminal_color_0  = s:black
let g:terminal_color_1  = s:red
let g:terminal_color_2  = s:green
let g:terminal_color_3  = s:yellow
let g:terminal_color_4  = s:blue
let g:terminal_color_5  = s:magenta
let g:terminal_color_6  = s:cyan
let g:terminal_color_7  = s:white
let g:terminal_color_8  = s:bright_black
let g:terminal_color_9  = s:bright_red
let g:terminal_color_10 = s:bright_green
let g:terminal_color_11 = s:bright_yellow
let g:terminal_color_12 = s:bright_blue
let g:terminal_color_13 = s:bright_magenta
let g:terminal_color_14 = s:bright_cyan
let g:terminal_color_15 = s:bright_white

" Basic highlights
exec "hi Normal          guifg=" . s:fg0 . " guibg=" . s:bg0
exec "hi NormalFloat    guifg=" . s:fg0 . " guibg=" . s:bg1
exec "hi NormalNC       guifg=" . s:fg1 . " guibg=" . s:bg0

exec "hi Comment        guifg=" . s:bright_black . " gui=italic"
exec "hi Constant       guifg=" . s:bright_cyan
exec "hi String         guifg=" . s:bright_green . " gui=italic"
exec "hi Character      guifg=" . s:bright_green
exec "hi Number         guifg=" . s:bright_yellow
exec "hi Boolean        guifg=" . s:bright_yellow
exec "hi Float          guifg=" . s:bright_yellow

exec "hi Identifier     guifg=" . s:bright_blue
exec "hi Function        guifg=" . s:bright_yellow

exec "hi Statement      guifg=" . s:bright_red . " gui=bold"
exec "hi Conditional    guifg=" . s:bright_red . " gui=bold"
exec "hi Repeat         guifg=" . s:bright_red . " gui=bold"
exec "hi Label          guifg=" . s:bright_red . " gui=bold"
exec "hi Operator       guifg=" . s:bright_red
exec "hi Keyword        guifg=" . s:bright_red . " gui=bold"
exec "hi Exception      guifg=" . s:bright_red . " gui=bold"

exec "hi PreProc        guifg=" . s:bright_magenta
exec "hi Include        guifg=" . s:bright_magenta
exec "hi Define         guifg=" . s:bright_magenta
exec "hi Macro          guifg=" . s:bright_magenta
exec "hi PreCondit      guifg=" . s:bright_magenta

exec "hi Type           guifg=" . s:bright_yellow . " gui=bold"
exec "hi StorageClass   guifg=" . s:bright_yellow . " gui=bold"
exec "hi Structure      guifg=" . s:bright_yellow . " gui=bold"
exec "hi Typedef        guifg=" . s:bright_yellow . " gui=bold"

exec "hi Special        guifg=" . s:bright_cyan
exec "hi SpecialChar    guifg=" . s:bright_cyan
exec "hi Tag            guifg=" . s:bright_cyan
exec "hi Delimiter      guifg=" . s:bright_cyan
exec "hi SpecialComment guifg=" . s:bright_black
exec "hi Debug          guifg=" . s:bright_red

exec "hi Underlined     guifg=" . s:bright_blue . " gui=underline"
exec "hi Ignore         guifg=" . s:bg0
exec "hi Error          guifg=" . s:bright_red . " guibg=" . s:bg0 . " gui=bold"
exec "hi Todo           guifg=" . s:bright_yellow . " guibg=" . s:bg0 . " gui=bold"

" Editor UI
exec "hi ColorColumn    guibg=" . s:bg1
exec "hi Conceal        guifg=" . s:bright_black
exec "hi Cursor         guifg=" . s:bg0 . " guibg=" . s:fg0
exec "hi CursorColumn   guibg=" . s:bg1
exec "hi CursorLine     guibg=" . s:bg2
exec "hi CursorLineNr   guifg=" . s:bright_yellow . " guibg=" . s:bg2 . " gui=bold"
exec "hi DiffAdd        guifg=" . s:bright_green . " guibg=" . s:bg0
exec "hi DiffChange     guifg=" . s:bright_yellow . " guibg=" . s:bg0
exec "hi DiffDelete     guifg=" . s:bright_red . " guibg=" . s:bg0
exec "hi DiffText       guifg=" . s:bright_blue . " guibg=" . s:bg0
exec "hi Directory      guifg=" . s:bright_blue
exec "hi EndOfBuffer    guifg=" . s:bg0
exec "hi ErrorMsg       guifg=" . s:bright_red . " guibg=" . s:bg0 . " gui=bold"
exec "hi FoldColumn     guifg=" . s:bright_black . " guibg=" . s:bg0
exec "hi Folded         guifg=" . s:bright_black . " guibg=" . s:bg1
exec "hi IncSearch      guifg=" . s:bg0 . " guibg=" . s:bright_yellow
exec "hi LineNr         guifg=" . s:bright_black . " guibg=" . s:bg0
exec "hi MatchParen     guifg=" . s:bright_yellow . " guibg=" . s:bg3 . " gui=bold"
exec "hi ModeMsg        guifg=" . s:bright_yellow
exec "hi MoreMsg        guifg=" . s:bright_yellow
exec "hi NonText        guifg=" . s:bright_black
exec "hi Pmenu          guifg=" . s:fg0 . " guibg=" . s:bg1
exec "hi PmenuSel       guifg=" . s:fg0 . " guibg=" . s:bg3 . " gui=bold"
exec "hi PmenuSbar      guibg=" . s:bg1
exec "hi PmenuThumb     guibg=" . s:bg3
exec "hi Question       guifg=" . s:bright_yellow
exec "hi QuickFixLine   guibg=" . s:bg2
exec "hi Search         guifg=" . s:bg0 . " guibg=" . s:bright_yellow
exec "hi SignColumn     guifg=" . s:bright_black . " guibg=" . s:bg0
exec "hi SpecialKey     guifg=" . s:bright_black
exec "hi SpellBad       guifg=" . s:bright_red . " gui=undercurl"
exec "hi SpellCap       guifg=" . s:bright_blue . " gui=undercurl"
exec "hi SpellLocal     guifg=" . s:bright_cyan . " gui=undercurl"
exec "hi SpellRare      guifg=" . s:bright_magenta . " gui=undercurl"
exec "hi StatusLine     guifg=" . s:fg0 . " guibg=" . s:bg2
exec "hi StatusLineNC   guifg=" . s:fg2 . " guibg=" . s:bg1
exec "hi TabLine        guifg=" . s:fg2 . " guibg=" . s:bg1
exec "hi TabLineFill    guifg=" . s:fg2 . " guibg=" . s:bg1
exec "hi TabLineSel     guifg=" . s:fg0 . " guibg=" . s:bg0
exec "hi Title          guifg=" . s:bright_yellow . " gui=bold"
exec "hi VertSplit      guifg=" . s:bg2 . " guibg=" . s:bg0
exec "hi Visual         guibg=" . s:bg3 . " gui=bold"
exec "hi VisualNOS      guibg=" . s:bg2
exec "hi WarningMsg     guifg=" . s:bright_yellow
exec "hi WildMenu       guifg=" . s:bg0 . " guibg=" . s:bright_yellow

" LSP
exec "hi LspReferenceText      guibg=" . s:bg3
exec "hi LspReferenceRead       guibg=" . s:bg3
exec "hi LspReferenceWrite      guibg=" . s:bg3 . " gui=bold"

" Diagnostic
exec "hi DiagnosticError        guifg=" . s:bright_red
exec "hi DiagnosticWarn         guifg=" . s:bright_yellow
exec "hi DiagnosticInfo         guifg=" . s:bright_blue
exec "hi DiagnosticHint         guifg=" . s:bright_cyan
exec "hi DiagnosticUnderlineError   guisp=" . s:bright_red . " gui=undercurl"
exec "hi DiagnosticUnderlineWarn    guisp=" . s:bright_yellow . " gui=undercurl"
exec "hi DiagnosticUnderlineInfo    guisp=" . s:bright_blue . " gui=undercurl"
exec "hi DiagnosticUnderlineHint     guisp=" . s:bright_cyan . " gui=undercurl"

" Float
exec "hi FloatBorder    guifg=" . s:bright_blue . " guibg=" . s:bg1

" Treesitter
exec "hi TSAnnotation    guifg=" . s:bright_magenta
exec "hi TSAttribute     guifg=" . s:bright_cyan
exec "hi TSBoolean       guifg=" . s:bright_yellow
exec "hi TSCharacter     guifg=" . s:bright_green
exec "hi TSComment       guifg=" . s:bright_black . " gui=italic"
exec "hi TSConditional   guifg=" . s:bright_red . " gui=bold"
exec "hi TSConstant      guifg=" . s:bright_cyan
exec "hi TSConstBuiltin  guifg=" . s:bright_yellow
exec "hi TSConstMacro    guifg=" . s:bright_magenta
exec "hi TSConstructor   guifg=" . s:bright_yellow
exec "hi TSError         guifg=" . s:bright_red
exec "hi TSException     guifg=" . s:bright_red . " gui=bold"
exec "hi TSField         guifg=" . s:bright_blue
exec "hi TSFloat         guifg=" . s:bright_yellow
exec "hi TSFuncBuiltin   guifg=" . s:bright_yellow
exec "hi TSFuncMacro     guifg=" . s:bright_magenta
exec "hi TSFunction      guifg=" . s:bright_yellow
exec "hi TSInclude       guifg=" . s:bright_magenta
exec "hi TSKeyword       guifg=" . s:bright_red . " gui=bold"
exec "hi TSKeywordFunction guifg=" . s:bright_red . " gui=bold"
exec "hi TSLabel         guifg=" . s:bright_red
exec "hi TSMethod        guifg=" . s:bright_yellow
exec "hi TSNamespace     guifg=" . s:bright_yellow . " gui=bold"
exec "hi TSNone          guifg=" . s:fg0
exec "hi TSNumber        guifg=" . s:bright_yellow
exec "hi TSOperator      guifg=" . s:bright_red
exec "hi TSParameter     guifg=" . s:bright_blue
exec "hi TSParameterReference guifg=" . s:bright_blue
exec "hi TSProperty      guifg=" . s:bright_blue
exec "hi TSPunctDelimiter guifg=" . s:bright_cyan
exec "hi TSPunctBracket  guifg=" . s:bright_cyan
exec "hi TSPunctSpecial  guifg=" . s:bright_cyan
exec "hi TSRepeat        guifg=" . s:bright_red . " gui=bold"
exec "hi TSString        guifg=" . s:bright_green . " gui=italic"
exec "hi TSStringRegex   guifg=" . s:bright_green
exec "hi TSStringEscape  guifg=" . s:bright_cyan
exec "hi TSSymbol        guifg=" . s:bright_cyan
exec "hi TSType          guifg=" . s:bright_yellow . " gui=bold"
exec "hi TSTypeBuiltin   guifg=" . s:bright_yellow . " gui=bold"
exec "hi TSVariable      guifg=" . s:fg0
exec "hi TSVariableBuiltin guifg=" . s:bright_yellow
exec "hi TSTag           guifg=" . s:bright_cyan
exec "hi TSTagDelimiter  guifg=" . s:bright_cyan
