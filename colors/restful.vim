" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer: Andrew Stewart
" 2003/11/28: created
" 2005/10/06: ported to PowerBook (set ff to unix)

"http://www.w3schools.com/html/ref_color_tryit.asp?hex=303030 
"http://www.people.fas.harvard.edu/~cduan/technical/vi/vi-4.html

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "restful"

hi Comment term=bold ctermfg=Red guifg=#99CCFF
hi Normal guifg=white guibg=#303030
hi Constant term=underline ctermfg=Magenta guifg=#99CC66
hi Special term=bold ctermfg=Magenta guifg=#C882C8
hi Identifier term=underline ctermfg=Blue guifg=#99CC00
hi Statement term=bold ctermfg=DarkRed gui=NONE guifg=#DDBC00
hi PreProc term=underline ctermfg=Magenta guifg=#D87093
hi Type term=underline ctermfg=Blue gui=NONE guifg=#FF6347
hi Visual term=reverse ctermfg=Yellow ctermbg=Red gui=NONE guifg=Black guibg=#AAAAAA
hi Search term=reverse ctermfg=Black ctermbg=Cyan gui=NONE guifg=Black guibg=#C0C0C0
hi Tag term=bold ctermfg=DarkGreen guifg=DarkGreen
hi Error term=reverse ctermfg=15 ctermbg=9 guibg=Red guifg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi  StatusLine term=bold,reverse cterm=NONE ctermfg=Yellow ctermbg=DarkGray gui=NONE guifg=Yellow guibg=DarkGray
hi! link MoreMsg Comment
hi! link ErrorMsg Visual
hi! link WarningMsg ErrorMsg
hi! link Question Comment
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Function	Identifier
hi link Conditional	Statement
hi link Repeat	Statement
hi link Label		Statement
hi link Operator	Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special
