if has("gui_macvim")
  set antialias                   " MacVim: smooth fonts.
  set encoding=utf-8              " MacVim: use UTF-8 everywhere.
  set guioptions-=T               " MacVim: hide toolbar.
  set guioptions-=r               " MacVim: hide right scrollbar.
endif

set background=dark               " Dark background.
colorscheme grb3                  " Gary Bernhardt: http://bitbucket.org/garybernhardt/dotfiles/src/tip/.vimrc
set guifont=Inconsolata:h11       " Decent font.

" external screen
set lines=103 columns=120         " Big window.
winpos 720 44                     " Centre of screen.
" laptop screen
"set lines=71 columns=120         " Big window.
"winpos 365 878                     " Centre of screen.

highlight SPELLING guibg=blue     " Highlight likely typos.
match SPELLING /toin/
