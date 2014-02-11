set nocompatible                  " Must come first because it changes other options.

" Manage the runtime path with  Pathogen.
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load matchit.vim plugin.

set background=dark
colorscheme solarized
hi LineNr guibg=NONE

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
set updatetime=750                " Do things when I stop typing for three-quarters of a second.

set notimeout                     " Don't time out partially entered mapped key sequences.
set ttimeout                      " But do time out key codes.

set tags=.git/tags,tags           " Look for tags in .git/

set clipboard=unnamed             " Use OS clipboard by default.

set cpo+=J                        " Two spaces delimit my sentences.
if v:version > 703 || (v:version == 703 && has("patch541"))
  set formatoptions+=j              " Remove comment leaders when joining lines.
endif

" Show tabs and trailing whitespace visually.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif

let g:sql_type_default = "mysql"

" Windowing.
nnoremap + <C-W>+
nnoremap - <C-W>-
nnoremap <C-s> <C-W>s
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

" Very magic regexes.
cnoremap s/ <C-\>eVeryMagic('s/')<CR>
cnoremap g/ <C-\>eVeryMagic('g/')<CR>
cnoremap v/ <C-\>eVeryMagic('v/')<CR>
function! VeryMagic(text)
  let cmd = getcmdline()
  return cmd . a:text . (cmd !~ '/' ? '\v' : '')
endfunction


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
" For anything more sophisticated, try:
" - https://github.com/nelstrom/vim-visual-star-search
" - https://github.com/thinca/vim-visualstar
vnoremap <silent> * yq/p<CR>
vnoremap <silent> # yq?p<CR>

" Duplicate and comment out duplicate.
nmap <leader>dc :t.<CR>k<Plug>CommentaryLinej

" Markdown preview.  http://rtomayko.github.com/bcat/
map <Leader>m :!markdown % <Bar>bcat<CR>

" Backspace closes buffer.
nnoremap <BS> :bd<CR>

" Prevent Vim from scrolling original window when splitting horizontally.
" See example 'Restoring the View' in Vim manual chapter 41.10.
nnoremap <C-W>s Hmx``:split<CR>`xzt``

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
autocmd FocusLost * nested silent! wa
autocmd FocusLost * if mode()[0] =~ 'i\|R' | call feedkeys("\<Esc>") | endif

" Wipe all buffers which aren't visible ('active').
" https://github.com/nelstrom/dotfiles/blob/8e8accf783aaf13e5407311f0d3079022152acf1/vimrc#L166-L189
command Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  " Get list of visible buffers
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " Close other buffers
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      execute 'bw ' . b
    endif
  endfor
endfunction




"
" Filetypes
"

au Filetype css setlocal iskeyword+=-
au Filetype ruby setlocal iskeyword+=_
au BufEnter *.js syn match ErrorMsg /console.log/


"
" Plugins
"

" PeepOpen
map <Leader>f <Plug>PeepOpen

" vim-commentary
" disable obsolete mapping
nmap \\ <space>

" BufExplorer configuration
"nmap <script> <silent> <unique> <CR> :BufExplorer<CR>
nmap <expr> <script> <silent> <unique> <CR> &buftype ==? '' ? ':BufExplorer<CR>' : '<CR>'
let g:bufExplorerDisableDefaultKeyMapping=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerShowDirectories = 0

" rails.vim configuration
autocmd User Rails silent! Rnavcommand config config -glob=*.* -suffix= -default=routes.rb

" ack.vim
nmap <silent> <unique> <Leader>a :Ack
nmap <silent> <unique> <Leader>as :AckFromSearch
nmap <silent> <unique> <Leader>af :AckFile
let g:ackprg = 'ag --nogroup --nocolor --column'

" vim-statline
let g:statline_syntastic = 0
let g:statline_show_n_buffers = 0
let g:statline_filename_relative = 1
let g:statline_mixed_indent = 0
"let g:statline_trailing_space = 0

" vim-rooter
map <Leader>r <Plug>RooterChangeToRootDirectory<CR>
let g:rooter_patterns = ['Rakefile', 'Gemfile', '.git/', 'CHANGELOG']

" vim-gitgutter
highlight clear SignColumn  " override default colorscheme
let g:gitgutter_sign_column_always = 1

" vim-airline
let g:airline_section_z = '%3l:%-3c [%{bufnr("%")}] '

