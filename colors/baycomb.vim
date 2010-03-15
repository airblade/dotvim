" Vim color file
" baycomb v0.7b
" http://www.vim.org/scripts/script.php?script_id=1454
" 
" Maintainer:	Shawn Axsom <axs221@gmail.com>
"
"   - Thanks to Desert and OceanDeep for their color scheme 
"     file layouts

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
		syntax reset
    endif
endif

let g:colors_name="baycomb"

hi Normal       guifg=#b8d0f0 guibg=#0e1b2e
hi NonText      guifg=#382920 guibg=#111a2a

" syntax highlighting
"hi Comment		guifg=#84ad88  "green
hi Comment		guifg=#dbd03b   "purple
hi Title		guifg=#f5f5d0  gui=none
hi Underlined   guifg=#dae5da

hi Statement    guifg=#ea727e  gui=none
hi Type			guifg=#40a5d5  "gui=none
hi Constant		guifg=#4c6bc8
hi PreProc      guifg=#9a60a0
hi Identifier   guifg=#c5604a  "or blue 4075aa  
                    """e09a4b
hi Special		guifg=#0ab5a0
hi Ignore       guifg=grey40
hi Todo			guifg=orangered guibg=yellow2
hi Error        guibg=#b03452
"""""this section borrowed from OceanDeep/Midnight"""""
hi Number guifg=#1a65b5
hi Function gui=None guifg=#f0ad80 guibg=bg "or green 50b3b0 
highlight Conditional gui=None guifg=#ca2043 guibg=bg
highlight Repeat gui=None guifg=#df4050 guibg=bg
"hi Label gui=None guifg=LightGreen guibg=bg
highlight Operator gui=None guifg=#fdb055 guibg=bg
highlight Keyword gui=bold guifg=grey guibg=bg
highlight Exception gui=bold guifg=#ee5534 guibg=bg
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"end syntax highlighting

" highlight groups
"hi CursorIM
hi Directory	guifg=#bbd0df
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
hi ErrorMsg     guibg=#ff4545

hi Cursor       guibg=#cad5c0 guifg=#05293d

hi FoldColumn	guibg=#83a5cd guifg=#70459F
hi LineNr       guibg=#081c30 guifg=#80a0dA 
hi StatusLine	guibg=#4080bd guifg=#0a150d gui=none
hi StatusLineNC	guibg=#45609a guifg=#302d34 gui=none

hi Search       guibg=#9a9d8d guifg=#3a4520
hi IncSearch	guifg=#caceba guibg=#3a4520 

hi VertSplit	guibg=#525f95 guifg=grey50 gui=none
hi Folded       guibg=#352f5d guifg=#BBDDCC
hi ModeMsg    	guifg=#00AACC
hi MoreMsg      guifg=SeaGreen
hi Question    	guifg=#AABBCC
hi SpecialKey	guifg=#b0dcc0
hi Visual       guifg=#008FBF guibg=#33DFEF
"hi VisualNOS
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar  guibg=grey30 guifg=tan
"hi Tooltip


" color terminal definitions
hi Number ctermfg=darkgreen
highlight Operator ctermfg=yellow
highlight Conditional ctermfg=red
highlight Repeat ctermfg=red
hi Exception ctermfg=red
hi function ctermfg=darkyellow
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=bold ctermfg=darkblue
hi Directory	ctermfg=darkcyan
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=darkgreen ctermbg=lightgrey
hi Search	cterm=NONE ctermfg=lightgreen ctermbg=darkgrey
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=darkcyan ctermbg=NONE
hi Question	ctermfg=green
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=darkyellow
hi Visual	cterm=reverse
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=darkgrey ctermbg=NONE
hi FoldColumn	ctermfg=darkgrey ctermbg=darkgrey
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Comment	ctermfg=magenta
hi Constant	ctermfg=blue
hi Special	ctermfg=darkgreen
hi Identifier	ctermfg=darkyellow
hi Statement	ctermfg=darkred
hi PreProc	ctermfg=5
hi Type		ctermfg=lightcyan
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1


"vim: sw=4


