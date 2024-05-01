" Vim color file
" Name:       256_noir.vim
" Maintainer: Andreas van Cranenburgh <andreas@unstable.nl>
" Homepage:   https://github.com/andreasvc/vim-256noir/

" Basically: dark background, numerals & errors red,
" rest different shades of gray.
"
" colors 232--250 are shades of gray, from dark to light;
" 16=black, 255=white, 196=red, 88=darkred.

highlight clear
set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name = "256_noir"

if has("gui_running") || &t_Co == 256
    hi Normal cterm=NONE ctermfg=250 ctermbg=16 gui=NONE guifg=#bcbcbc guibg=#000000
    hi Keyword cterm=NONE ctermfg=255 ctermbg=16 gui=NONE guifg=#eeeeee guibg=#000000
    hi Constant cterm=NONE ctermfg=252 ctermbg=16 gui=NONE guifg=#d0d0d0 guibg=#000000
    hi String cterm=NONE ctermfg=245 ctermbg=16 gui=NONE guifg=#8a8a8a guibg=#000000
    hi Comment cterm=NONE ctermfg=240 ctermbg=16 gui=NONE guifg=#585858 guibg=#000000
    hi Number cterm=NONE ctermfg=196 ctermbg=16 gui=NONE guifg=#ff0000 guibg=#000000
    hi Error cterm=NONE ctermfg=255 ctermbg=88 gui=NONE guifg=#eeeeee guibg=#870000
    hi ErrorMsg cterm=NONE ctermfg=255 ctermbg=124 gui=NONE guifg=#eeeeee guibg=#af0000
    hi Search cterm=NONE ctermfg=245 ctermbg=236 gui=NONE guifg=#8a8a8a guibg=#303030
    hi IncSearch cterm=reverse ctermfg=255 ctermbg=245 gui=reverse guifg=#eeeeee guibg=#8a8a8a
    hi DiffChange cterm=NONE ctermfg=160 ctermbg=255 gui=NONE guifg=#d70000 guibg=#eeeeee
    hi DiffText cterm=bold ctermfg=250 ctermbg=196 gui=bold guifg=#bcbcbc guibg=#ff0000
    hi SignColumn cterm=NONE ctermfg=124 ctermbg=240 gui=NONE guifg=#af0000 guibg=#585858
    hi SpellBad cterm=undercurl ctermfg=255 ctermbg=88 gui=undercurl guifg=#eeeeee guibg=#870000
    hi SpellCap cterm=NONE ctermfg=255 ctermbg=124 gui=NONE guifg=#eeeeee guibg=#af0000
    hi SpellRare cterm=NONE ctermfg=124 ctermbg=16 gui=NONE guifg=#af0000 guibg=#000000
    hi WildMenu cterm=NONE ctermfg=240 ctermbg=255 gui=NONE guifg=#585858 guibg=#eeeeee
    hi Pmenu cterm=NONE ctermfg=255 ctermbg=240 gui=NONE guifg=#eeeeee guibg=#585858
    hi PmenuThumb cterm=NONE ctermfg=232 ctermbg=240 gui=NONE guifg=#080808 guibg=#585858
    hi SpecialKey cterm=NONE ctermfg=16 ctermbg=255 gui=NONE guifg=#000000 guibg=#eeeeee
    hi MatchParen cterm=NONE ctermfg=16 ctermbg=240 gui=NONE guifg=#000000 guibg=#585858
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=233 gui=NONE guifg=NONE guibg=#121212
    hi StatusLine cterm=bold,reverse ctermfg=245 ctermbg=16 gui=bold,reverse guifg=#8a8a8a guibg=#000000
    hi StatusLineNC cterm=reverse ctermfg=236 ctermbg=16 gui=reverse guifg=#303030 guibg=#000000
    hi Visual cterm=reverse ctermfg=250 ctermbg=16 gui=reverse guifg=#bcbcbc guibg=#000000
    hi TermCursor cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
else
    hi Normal cterm=NONE ctermfg=Gray ctermbg=Black
    hi Keyword cterm=NONE ctermfg=White ctermbg=Black
    hi Constant cterm=NONE ctermfg=Gray ctermbg=Black
    hi String cterm=NONE ctermfg=Gray ctermbg=Black
    hi Comment cterm=NONE ctermfg=DarkGray ctermbg=Black
    hi Number cterm=NONE ctermfg=Red ctermbg=Black
    hi Error cterm=NONE ctermfg=White ctermbg=DarkRed
    hi ErrorMsg cterm=NONE ctermfg=White ctermbg=Red
    hi Search cterm=NONE ctermfg=Gray ctermbg=DarkGray
    hi IncSearch cterm=reverse ctermfg=White ctermbg=Gray
    hi DiffChange cterm=NONE ctermfg=Red ctermbg=White
    hi DiffText cterm=bold ctermfg=Gray ctermbg=Red
    hi SignColumn cterm=NONE ctermfg=Red ctermbg=DarkGray
    hi SpellBad cterm=undercurl ctermfg=White ctermbg=DarkRed
    hi SpellCap cterm=NONE ctermfg=White ctermbg=Red
    hi SpellRare cterm=NONE ctermfg=Red ctermbg=Black
    hi WildMenu cterm=NONE ctermfg=DarkGray ctermbg=White
    hi Pmenu cterm=NONE ctermfg=White ctermbg=DarkGray
    hi PmenuThumb cterm=NONE ctermfg=Black ctermbg=DarkGray
    hi SpecialKey cterm=NONE ctermfg=Black ctermbg=White
    hi MatchParen cterm=NONE ctermfg=Black ctermbg=DarkGray
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=Black
    hi StatusLine cterm=bold,reverse ctermfg=Gray ctermbg=Black
    hi StatusLineNC cterm=reverse ctermfg=DarkGray ctermbg=Black
    hi Visual cterm=reverse ctermfg=Gray ctermbg=Black
    hi TermCursor cterm=reverse ctermfg=NONE ctermbg=NONE
endif
highlight! link Boolean Normal
highlight! link Delimiter Normal
highlight! link Identifier Normal
highlight! link Title Normal
highlight! link Debug Normal
highlight! link Exception Normal
highlight! link FoldColumn Normal
highlight! link Macro Normal
highlight! link ModeMsg Normal
highlight! link MoreMsg Normal
highlight! link Question Normal
highlight! link Conditional Keyword
highlight! link Statement Keyword
highlight! link Operator Keyword
highlight! link Structure Keyword
highlight! link Function Keyword
highlight! link Include Keyword
highlight! link Type Keyword
highlight! link Typedef Keyword
highlight! link Todo Keyword
highlight! link Label Keyword
highlight! link Define Keyword
highlight! link DiffAdd Keyword
highlight! link diffAdded Keyword
highlight! link diffCommon Keyword
highlight! link Directory Keyword
highlight! link PreCondit Keyword
highlight! link PreProc Keyword
highlight! link Repeat Keyword
highlight! link Special Keyword
highlight! link SpecialChar Keyword
highlight! link StorageClass Keyword
highlight! link SpecialComment String
highlight! link CursorLineNr String
highlight! link Character Number
highlight! link Float Number
highlight! link Tag Number
highlight! link Folded Number
highlight! link WarningMsg Number
highlight! link iCursor SpecialKey
highlight! link SpellLocal SpellCap
highlight! link LineNr Comment
highlight! link NonText Comment
highlight! link DiffDelete Comment
highlight! link diffRemoved Comment
highlight! link PmenuSbar Visual
highlight! link PmenuSel Visual
highlight! link VisualNOS Visual
highlight! link VertSplit Visual
highlight! link Cursor StatusLine
highlight! link Underlined SpellRare
highlight! link rstEmphasis SpellRare
highlight! link diffChanged DiffChange
