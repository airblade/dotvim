set nocompatible                  " Must come first because it changes other options.

" Manage the runtime path with  Pathogen.
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load matchit.vim plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show absolute line numbers (cf. relativenumber).
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set shiftwidth=2                  " 
set tabstop=2                     " Tabs and spaces.
set expandtab                     " 

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " No backups.
set nowritebackup                 " No backups.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location to simplify crash recovery.

set tildeop                       " Make tilde command behave like an operator.
set shortmess=atI                 " Avoid unnecessary hit-enter prompts.

set noequalalways                 " Resize windows as little as possible.

set autoread                      " Automatically re-read files changed outside Vim.

let g:sql_type_default = "mysql"

" Very magic regexes.
nnoremap / /\v
vnoremap / /\v

" Capitalise the first letter of every word on a line.
nnoremap <Leader>u :s/\<./\u&/g<CR>

" <Leader><space> turns off search highlighting.
nnoremap <Leader><space> :noh<CR>

" Open directory of current file.
cnoremap ecd edit <c-r>=expand("%:h")<CR><CR>
" Change directory to current file's.
cnoremap cdc cd <c-r>=expand("%:h")<CR><CR>

" Map § to # for typing convenience
set iminsert=1
set imsearch=-1
noremap  § #
noremap! § #
lnoremap § #

" Make Y consistent with D and C (instead of yy)
noremap Y y$

" Visually select the text that was most recently edited/pasted.
nmap gV `[v`]

" Make * and # work with visual selection.
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Save on losing focus
"au FocusLost * :wa


" TODO:
" - move this Ruby commenting into a filetype plugin.
" - use `comments` option.

" Enclose visual selection with =begin and =end.
vmap <Leader>c <Esc>'<O=begin<Esc>'>o=end<Esc>

" Remove enclosing =begin and =end.
nmap <silent> <Leader>z :call ZapComment()<CR>
function! ZapComment()
  let pos = getpos(".")
  let line_number = search("=begin", "bc")
  if line_number > 0
    exe line_number . "d _"
  endif
  let line_number = search("=end", "c")
  if line_number > 0
    exe line_number . "d _"
  endif
  let pos[1] = pos[1] - 1
  call setpos('.', pos)
endfunction

" Markdown preview.  http://rtomayko.github.com/bcat/
map <Leader>pm :!markdown % <Bar>bcat<CR>

" Use cursor keys to navigate buffers.
map  <Right> :bnext<CR>
map  <Left>  :bprev<CR>
imap <Right> <ESC>:bnext<CR>
imap <Left>  <ESC>:bprev<CR>
map  <Del>   :bd<CR>

" Show tabs and trailing whitespace visually
" http://github.com/ciaranm/dotfiles-ciaranm/blob/master/vimrc
if (&termencoding == "utf-8") || has("gui_running")
  if v:version >= 700
    if has("gui_running")
      set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
    else
      " xterm + terminus hates these
      set list listchars=tab:»·,trail:·,extends:>,nbsp:_
    endif
  else
    set list listchars=tab:»·,trail:·,extends:…
  endif
else
  if v:version >= 700
    set list listchars=tab:>-,trail:.,extends:>,nbsp:_
  else
    set list listchars=tab:>-,trail:.,extends:>
  endif
endif


"
" Plugins
"


" PeepOpen
map <Leader>f <Plug>PeepOpen

" FuzzyFinder TextMate
"map <Leader>t :FuzzyFinderTextMate<CR>
"map <Leader>r :FuzzyFinderTextMateRefreshFiles<CR>
"let g:fuzzy_ignore = "*.log,db/sphinx/**"
"let g:fuzzy_matching_limit = 30

" BufExplorer configuration
let g:bufExplorerShowRelativePath=1
"let g:bufExplorerShowUnlisted=1

" rails.vim configuration
autocmd User Rails silent! Rnavcommand config config -glob=*.* -suffix= -default=routes.rb
autocmd User Rails silent! Rnavcommand ncss app/views/stylesheets -glob=* -suffix=.css.ncss -default=application

" ack.vim
nmap <silent> <unique> <Leader>a :Ack
nmap <silent> <unique> <Leader>as :AckFromSearch
nmap <silent> <unique> <Leader>af :AckFile
