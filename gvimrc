if has("gui_macvim")
  set antialias                   " MacVim: smooth fonts.
  set encoding=utf-8              " MacVim: use UTF-8 everywhere.
  set guioptions-=T               " MacVim: hide toolbar.
  set guioptions-=r               " MacVim: hide right scrollbar.
  set guioptions-=R               " MacVim: hide right scrollbar.
  set guioptions-=l               " MacVim: hide left scrollbar.
  set guioptions-=L               " MacVim: hide left scrollbar.
endif

hi StatusLine   guifg=White guibg=#073642
hi StatusLineNC guifg=White guibg=#073642

" highlight values in macvim, colorscheme solarized
hi User1 cterm=bold ctermfg=11 guifg=#268bd2
hi User2 ctermfg=14 guifg=#859900
hi User3 term=bold ctermfg=15 ctermbg=12 gui=bold guifg=#dc322f
hi User4 ctermfg=12 guifg=#dc322f
hi User5 term=italic ctermfg=11 gui=italic guifg=#586e75
hi User6 term=bold ctermfg=12 gui=bold guifg=#dc322f

hi User1 guibg=#073642
hi User2 guibg=#073642
hi User3 guibg=#073642
hi User4 guibg=#073642
hi User5 guibg=#073642
hi User6 guibg=#073642

set guifont=Inconsolata:h13

highlight SPELLING guibg=blue     " Highlight likely typos.
match SPELLING /toin/

" Size and position window for different displays.

function! Cinema()
  set lines=126 columns=124
  winpos 1075 1570
endfunction

function! Laptop()
  set lines=71 columns=120
  winpos 365 878
endfunction
