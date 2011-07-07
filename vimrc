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
set laststatus=2                  " Always show a status line.

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
set noswapfile                    " No swap files; more hassle than they're worth.

set tildeop                       " Make tilde command behave like an operator.
set shortmess=atI                 " Avoid unnecessary hit-enter prompts.

set noequalalways                 " Resize windows as little as possible.

set autoread                      " Automatically re-read files changed outside Vim.

let g:sql_type_default = "mysql"

" Very magic regexes.
nnoremap / /\v
vnoremap / /\v

" OS X-like space bar to scroll.
nnoremap <Space> <C-F>

" <Leader><space> turns off search highlighting.
nnoremap <Leader><space> :noh<CR>

" Kill trailing White Space
nnoremap <Leader>kws :%s/\s\+$//<CR>

" <Leader>s shrinks current window to fit size of buffer.
nnoremap <silent> <Leader>s :call ShrinkWindow()<CR>
function! ShrinkWindow()
  let line_count = line('$')
  let window_height = winheight(0)
  if window_height > line_count
    execute "resize" line_count
  endif
endfunction

" Directory of current file.
cnoremap %% <C-R>=expand("%:h")."/"<CR>

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
"
" See also here for a different solution:
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
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
nmap <script> <silent> <unique> <Leader><Leader> :BufExplorer<CR>
let g:bufExplorerShowRelativePath=1
"let g:bufExplorerShowUnlisted=1

" rails.vim configuration
autocmd User Rails silent! Rnavcommand config config -glob=*.* -suffix= -default=routes.rb
autocmd User Rails silent! Rnavcommand ncss app/views/stylesheets -glob=* -suffix=.css.ncss -default=application

" ack.vim
nmap <silent> <unique> <Leader>a :Ack
nmap <silent> <unique> <Leader>as :AckFromSearch
nmap <silent> <unique> <Leader>af :AckFile

" Tabularize
"if exists(':Tabularize')
"           ^^^^^^^^^^^^ for some reason Tabularize hasn't loaded when Vim gets here
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
" key => value
nmap <Leader>t> :Tabularize /=><CR>
vmap <Leader>t> :Tabularize /=><CR>
" key: value
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
" Ruby symbols
nmap <Leader>ts :Tabularize /:/l1c0l0<CR>
vmap <Leader>ts :Tabularize /:/l1c0l0<CR>

" Auto-align Cucumber tables as you type.
" N.B. either the line above or the line below must already be formatted with
" spaces around the pipes.
" https://gist.github.com/287147
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    " Calculate column cursor is in, and offset within that column,
    " so we can place the cursor in the right place after Tabularize
    " has done its thing.
    "
    " The 1-based index of the column the cursor's in.
    " getline('.')[0:col('.')] returns current line from 0 to one character
    " to right of cursor inclusive...remember all this is called when you
    " type a |
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    " Offset within the column.  Equals 1 when you type |
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    " Go to start of current line.
    normal! 0
    " Return cursor to starting offset within starting column.
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"endif
