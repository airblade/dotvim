
if has("gui_macvim")
  set antialias                   " MacVim: smooth fonts.
  set encoding=utf-8              " MacVim: use UTF-8 everywhere.
  set guioptions-=T               " MacVim: hide toolbar.
  set guioptions-=r               " MacVim: hide right scrollbar.
  set guioptions-=L               " MacVim: hide left scrollbar.
endif

set background=dark               " Dark background.
colorscheme grb3                  " Gary Bernhardt: http://bitbucket.org/garybernhardt/dotfiles/src/tip/.vimrc
set guifont=Inconsolata:h11       " Decent font.

highlight SPELLING guibg=blue     " Highlight likely typos.
match SPELLING /toin/

" Size and position window for different displays.

nnoremap <silent> <Leader>dc :call Cinema()<CR>
function! Cinema()
  set lines=126 columns=124
  winpos 1075 1570
endfunction

nnoremap <silent> <Leader>dl :call Laptop()<CR>
function! Laptop()
  set lines=71 columns=120
  winpos 365 878
endfunction
