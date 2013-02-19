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
set complete-=i                   " Don't look in included files.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show absolute line numbers (cf. relativenumber).
set ruler                         " Show cursor position.
set laststatus=2                  " Always show a status line.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set display+=lastline             " Display as much as possibe of a window's last line.

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

set notimeout                     " Don't time out partially entered mapped key sequences.
set ttimeout                      " But do time out key codes.

set tags=.git/tags,tags           " Look for tags in .git/

set clipboard=unnamed             " Use OS clipboard by default.

" Show tabs and trailing whitespace visually.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif

let g:sql_type_default = "mysql"

" Make + and - increase/decrease the window size.
nnoremap + <C-W>+
nnoremap - <C-W>-

" Very magic regexes.
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

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

" Copy to / paste from system pasteboard.
" (Use `:put *<CR>` and `:put! *<CR>` for linewise pasting.)
noremap <Leader>y "*y
noremap <Leader>p :set paste<CR>"*p:set nopaste<CR>
noremap <Leader>P :set paste<CR>"*P:set nopaste<CR>

" Make Y consistent with D and C (instead of yy)
noremap Y y$

" Visually select the text that was most recently edited/pasted.
" Note: gv selects previously selected area.
nmap gV `[v`]

" Duplicate visual selection.
vmap D yP'<

" Make * and # work with visual selection.
" For anything more sophisticated, try https://github.com/thinca/vim-visualstar
vnoremap <silent> * yq/p<CR>
vnoremap <silent> # yq?p<CR>

" Markdown preview.  http://rtomayko.github.com/bcat/
map <Leader>m :!markdown % <Bar>bcat<CR>

" Backspace closes buffer.
nnoremap <BS> :bd<CR>

" Prevent Vim from scrolling original window when splitting horizontally.
" See example 'Restoring the View' in Vim manual chapter 41.10.
nnoremap <C-W>s Hmx``:split<CR>`xzt``

" Ruby: convert 1.8 hash syntax to 1.9, e.g `:foo => bar` to `foo: bar`.
map <Leader>h :s/\v:(\w+)\s*\=\>\s*(\S)/\1: \2/<CR>:noh<CR>

" Save all buffers when focus lost, ignoring warnings,
" and return to normal mode.
"
" Ideally we'd have:
"
"   autocmd FocusLost * silent! wa stopinsert
"
" but stopinsert doesn't seem to work inside a FocusLost autocommand.
" So we use a long-winded approach instead.
"
" http://tech.groups.yahoo.com/group/vim/message/94986
autocmd FocusLost * silent! wa
autocmd FocusLost * if mode()[0] =~ 'i\|R' | call feedkeys("\<Esc>") | endif


"
" Filetypes
"

au Filetype css setlocal iskeyword+=-
au Filetype ruby setlocal iskeyword+=_


"
" Plugins
"


" vim-commentary
xmap <Leader>c  <Plug>Commentary
nmap <Leader>c  <Plug>Commentary
nmap <Leader>cc <Plug>CommentaryLine

" PeepOpen
map <Leader>f <Plug>PeepOpen

" BufExplorer configuration
nmap <script> <silent> <unique> <Leader><Leader> :BufExplorer<CR>
let g:bufExplorerShowRelativePath=1
"let g:bufExplorerShowUnlisted=1

" rails.vim configuration
autocmd User Rails silent! Rnavcommand config config -glob=*.* -suffix= -default=routes.rb

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

" vim-statline
let g:statline_syntastic = 0
let g:statline_show_n_buffers = 0
let g:statline_filename_relative = 1
let g:statline_mixed_indent = 0
"let g:statline_trailing_space = 0

" vim-rooter
map <Leader>r <Plug>RooterChangeToRootDirectory<CR>
let g:rooter_patterns = ['Rakefile', '.git/', 'CHANGELOG']
