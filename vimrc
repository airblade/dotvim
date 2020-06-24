syntax enable
filetype plugin indent on

set background=dark
colorscheme nova
highlight! link SignColumn LineNr

set backspace=indent,eol,start
set hidden
set wildmenu
set wildignorecase
set wildmode=list:longest,full
set wildignore+=tags,cscope.*
set wildignore+=*/min/*
set wildignore+=*/.git/**/*
set wildignore+=*/node_modules/**/*
set wildignore+=*/tmp/**/*
set path=.,,

set complete-=i  " Don't look in included files.

set completeopt=menu

set nrformats-=octal

set signcolumn=yes

set splitbelow
set splitright

" Ideally I'd like:
" - case-sensitive insert-mode completion
" - smart case-insensitive searching
" It looks like you can't have both through configuration;
" you have to write a customer completion function.
" For now I prioritise the first requirement.
" set ignorecase                    " Case-insensitive searching.
" set smartcase                     " But case-sensitive if expression contains a capital letter.

set number
set ruler
set laststatus=2


hi clear StatusLine
hi clear StatusLineNC
hi StatusLine   term=bold cterm=bold ctermfg=White ctermbg=235
hi StatusLineNC term=bold cterm=bold ctermfg=White ctermbg=235

" highlight values in terminal vim, colorscheme solarized
hi User1                      ctermfg=4          guifg=#40ffff            " Identifier
hi User2                      ctermfg=2 gui=bold guifg=#ffff60            " Statement
hi User3 term=bold cterm=bold ctermfg=1          guifg=White   guibg=Red  " Error
hi User4                      ctermfg=1          guifg=Orange             " Special
hi User5                      ctermfg=10         guifg=#80a0ff            " Comment
hi User6 term=bold cterm=bold ctermfg=1          guifg=Red                " WarningMsg

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

function! TrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    let lineno = search('\s$', 'nw')
    if lineno != 0
      let b:statusline_trailing_space_warning = '[trailing:'.lineno.']'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

" recalculate when idle, and after saving
augroup statusline_trail
  autocmd!
  autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_space_warning
augroup END

set statusline=
set statusline+=%6*%m%r%*                          " modified, readonly
set statusline+=\ 
set statusline+=%5*%{expand('%:h')}/               " relative path to file's directory
set statusline+=%1*%t%*                            " file name
set statusline+=\ 
set statusline+=\ 
set statusline+=%3*%{TrailingSpaceWarning()}%*     " trailing whitespace

set statusline+=\ 
set statusline+=%{kite#statusline()}

set statusline+=%=                                 " switch to RHS

set statusline+=%5*%{empty(&titlestring)?'':&titlestring}%*
set statusline+=\ 
set statusline+=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
set statusline+=\ 
set statusline+=\ 
set statusline+=%5*%L\ lines%*                     " number of lines
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=%2*%-2.2{WindowNumber()}%*         " window number


set incsearch
set hlsearch

set wrap
set breakindent
set breakindentopt=sbr
" Unicode curly arrow, space
set showbreak=↪> 
set scrolloff=3
set display+=lastline

set shiftwidth=2
set tabstop=2
set expandtab

set title

if has('nvim')
  autocmd VimLeave * set titleold=:)
endif

set visualbell
set belloff+=ctrlg  " prevent beeping during completion

set nobackup
set nowritebackup
set noswapfile

set shortmess=atIc

set noequalalways

set autoread
set updatetime=100

set notimeout
set ttimeout
if !has('nvim')
  " Avoid delay with O immediately after Esc.
  " http://stackoverflow.com/a/2158610/151007
  set noesckeys
endif

set tags=.git/tags,tags

set clipboard=unnamed

" Ensure pathogen can load plugins when restoring a vim session.
set sessionoptions-=options

set cpo+=J                        " Two spaces delimit my sentences.
set formatoptions+=j              " Remove comment leaders when joining lines.

set grepprg=rg\ --vimgrep\ --smart-case
set grepformat=%f:%l:%c:%m
" :Grep pattern [directory]
command! -bang -nargs=+ -complete=file Grep silent grep! <q-args> |
      \ let @/=split("<args>")[0] |
      \ call feedkeys(":let &hlsearch=1\<CR>", "n") |
      \ copen |
      \ redraw!
nnoremap <Leader>g :Grep

" Project-specific vimrc
set exrc
set secure

nnoremap gK K
" Opposite of join (breaK?).
" A space is replaced with a carriage return; otherwise a carriage return is inserted.
nnoremap <expr> K getline('.')[col('.') - 1] == ' ' ? "r<CR>" : "i<CR><ESC>l"


" Show tabs and trailing whitespace visually.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif
autocmd InsertEnter * set nolist
autocmd InsertLeave * set list

" Highlight non-ASCII characters.
" syntax match nonascii "[^\x00-\x7F]"
" highlight link nonascii ErrorMsg
autocmd BufEnter * syn match ErrorMsg /[^\x00-\x7F]/

" Treat buffers from stdin as scratch.
au StdinReadPost * :set buftype=nofile

" Windowing.
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W
" Use | and _ to split windows (while preserving original behaviour of [count]bar and [count]_).
nnoremap <expr><silent> <Bar> v:count == 0 ? "<C-W>v" : ":<C-U>normal! 0".v:count."<Bar><CR>"
nmap     <expr><silent> _     v:count == 0 ? "<C-W>s" : ":<C-U>normal! ".v:count."_<CR>"
" Jump to window <n>:
" http://stackoverflow.com/a/6404246/151007
for i in range(1, 9)
  execute 'nnoremap <Leader>'.i.' :'.i.'wincmd w<CR>'
endfor
" Jump to previous window:
execute 'nnoremap <Leader>0 :wincmd p<CR>'


" Move current line / visual line selection up or down.
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
xnoremap <C-j> :m'>+<CR>gv=gv
xnoremap <C-k> :m-2<CR>gv=gv

" gm jumps to middle of current screen line's text.
"
" (Middle of entire line is easier: virtcol('$')/2)
function! GotoMiddle()
  " Get buffer width. (http://stackoverflow.com/a/26318602/151007)
  redir => signlist
    execute "silent sign place buffer=".bufnr('')
  redir end
  let signlist = split(signlist, '\n')
  let width = winwidth(0) - &numberwidth - &foldcolumn - (len(signlist) > 2 ? 2 : 0)

  normal g^
  let first_non_blank_char = col('.') % width
  normal g$
  let last_non_blank_char = 1 + ((col('.')-1) % width)
  let middle_non_blank_char = first_non_blank_char + (last_non_blank_char - first_non_blank_char) / 2
  execute "normal g0".middle_non_blank_char."l"
endfunction
nnoremap <silent> gm :call GotoMiddle()<CR>

" OS X-like space bar to scroll.
nnoremap <Space> <C-F>

" <Leader><space> turns off search highlighting and enable CSS highlighting.
if exists("*css_color#enable()")
  nnoremap <Leader><space> :call css_color#enable()<CR>:noh<CR>
else
  nnoremap <Leader><space> :noh<CR>
endif

" Hide CSS highlight when searching so search highlight is visible
if exists("*css_color#disable()")
  nnoremap / :call css_color#disable()<CR>/
endif

" Directory of current file.
cnoremap %% <C-R>=expand("%:h")."/"<CR>

" Make Y consistent with D and C (instead of yy)
nnoremap Y y$

" ~ toggles ' and " in addition to its normal behaviour
" TODO toggle - and _
nnoremap <expr> ~ getline('.')[col('.')-1] == "'" ? "r\"l" : getline('.')[col('.')-1] == '"' ? "r'l" : '~'

" Visually select the text that was most recently edited/pasted.
" Note: gv selects previously selected area.
nmap gV `[v`]

" Retain cursor position when visually yanking.
xnoremap <expr> y 'my"'.v:register.'y`y'
xnoremap <expr> Y 'my"'.v:register.'Y`y'

" Make * and # work with visual selection.
" For anything more sophisticated, try:
" - https://github.com/nelstrom/vim-visual-star-search
" - https://github.com/thinca/vim-visualstar
xnoremap <silent> * yq/p<CR>
xnoremap <silent> # yq?p<CR>

" Backspace closes buffer.
nnoremap <BS> :Bclose<CR>

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

" Wipe all hidden buffers.
command! Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  let visible = []
  for i in range(1, tabpagenr('$'))
    call extend(visible, tabpagebuflist(i))
  endfor
  for b in filter(range(1, bufnr('$')), {_,b -> bufloaded(b) && index(visible,b) == -1})
    execute 'bw' b
  endfor
endfunction


function! Browse(url)
  if !exists('g:loaded_netrw')
    runtime! autoload/netrw.vim
  endif
  if exists('*netrw#BrowseX')
    call netrw#BrowseX(a:url, 0)
  else
    call netrw#NetrwBrowseX(a:url, 0)
  endif
endfunction
nnoremap gb :<C-U>call Browse(expand('<cfile>'))<CR>


"
" Filetypes
"

au Filetype css setlocal iskeyword+=-
au Filetype ruby setlocal iskeyword+=_
au BufEnter *.js syn match ErrorMsg /console.log/
au Filetype coffee syn match ErrorMsg /console.log/
au Filetype ruby syn match ErrorMsg /puts/
au FileType eruby.yaml,yaml,yml setlocal commentstring=#\ %s


"
" Colours
"

" hi clear Search
" hi Search guifg=#ffffff guibg=#789abc


function! s:Pulse()
  setlocal cursorline
  redraw
  sleep 100m

  setlocal nocursorline
  redraw
  sleep 100m

  setlocal cursorline
  redraw
  sleep 100m

  setlocal nocursorline
  redraw
endfunction
autocmd FocusGained * call s:Pulse()


" i18n
" 'foo' -> t('.')
" nmap <Leader>t ysa')it<Esc>f'ci'.
iab han human_attribute_name
iab mnh model_name.human


" syntax checker
nnoremap <Leader>s :w \| !sinter %<CR>


"
" Text objects
"

" Extra text objects.
" Thanks romainl (https://stackoverflow.com/a/44109750)
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#' ]
    execute 'xnoremap i'.char.' :<C-U>normal! T'.char.'vt'.char.'<CR>'
    execute 'onoremap i'.char.' :normal vi'.char.'<CR>'
    " The 'around' text objects exclude the end character
    " (so they work better with lists).
    execute 'xnoremap a'.char.' :<C-U>normal! F'.char.'vt'.char.'<CR>'
    execute 'onoremap a'.char.' :normal va'.char.'<CR>'
endfor

" Narrow word text object: optional upper-case letter followed by lower-case letters
" Thanks DJMcMayhem (https://vi.stackexchange.com/a/12491)
" Thanks Rich (https://vi.stackexchange.com/a/12502)
" On MacVim the forward-search matches are highlighted so turn off the
" highlighting.
xnoremap in :<C-U>normal! l?\a\l\+?s<C-V><CR>v/\L/s-<C-V><CR>v:nohlsearch<C-V><CR>gv<CR>
onoremap in :normal vin<CR>


function! s:indentation(inner)
  let indent = indent(line('.'))

  if indent == 0
    if !empty(getline('.'))
      return
    endif

    let line = line('.')
    while empty(getline(line))
      normal! j
      let line += 1
    endwhile
    return s:indentation(a:inner)
  endif

  let first_line = search('\v^\s{,'.(indent-1).'}\S', 'nWb') + 1
  let last_line  = search('\v^\s{,'.(indent-1).'}\S', 'nW')  - 1

  if a:inner
    while empty(getline(first_line))
      let first_line += 1
    endwhile

    while empty(getline(last_line))
      let last_line -= 1
    endwhile
  endif

  " line-wise
  execute 'normal! '.first_line.'GV'.last_line.'G'
endfunction

xnoremap <silent> ii :<c-u>call <sid>indentation(1)<cr>
onoremap <silent> ii :<c-u>call <sid>indentation(1)<cr>
xnoremap <silent> ai :<c-u>call <sid>indentation(0)<cr>
onoremap <silent> ai :<c-u>call <sid>indentation(0)<cr>


"
" Plugins
"

packadd! matchit

" Disable unwanted built-in plugins.
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_netrwPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1


" Helpful.vim
let g:helpful=1


" Any Jump
let g:any_jump_results_ui_style = 'filename_last'
let g:any_jump_grouping_enabled = 1


" BufExplorer configuration
nmap <expr> <script> <silent> <unique> <CR> &buftype ==? '' ? ':BufExplorer<CR>' : '<CR>'
let g:bufExplorerDefaultHelp=0
let g:bufExplorerDisableDefaultKeyMapping=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowNoName=1

" vim-gitgutter
xmap ghs <Plug>(GitGutterStageHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" vim-localorie
nnoremap <silent> <leader>lt :call localorie#translate()<CR>
nnoremap <silent> <leader>le :call localorie#expand_key()<CR>

" vim-rooter
let g:rooter_patterns = ['.root', 'Rakefile', 'Gemfile', '.git/', 'CHANGELOG']
let g:rooter_change_directory_for_non_project_files = 'current'

" vim-surround
" Add replacement on # for ruby string interplation.
let g:surround_35 = "#{\r}"


" Open a gem's homepage in the browser.  This is a bit of a hack :/
" TODO: gemfile only
" nmap <silent> <Leader>g :call system("open $(gem list -d " . expand('<cword>') . " \| awk '/Homepage/ {print $2}')")<CR>

" vim-projectionist
let g:projectionist_heuristics = {
  \   "Gemfile&config/application.rb": {
  \     "app/models/*.rb": {
  \       "template": ["class {camelcase|capitalize} < ApplicationRecord", "end"]
  \     },
  \     "app/controllers/*.rb": {
  \       "template": ["class {camelcase|capitalize} < ApplicationController", "end"],
  \     },
  \     "app/jobs/*.rb": {
  \       "template": ["class {camelcase|capitalize} < ApplicationJob", "end"],
  \       "type": "presenter"
  \     },
  \     "app/presenters/*.rb": {
  \       "template": ["class {camelcase|capitalize}", "end"],
  \       "type": "presenter"
  \     },
  \     "app/frontend/styles/*.sass": {
  \       "type": "sass"
  \     },
  \     "app/frontend/javascripts/controllers/*_controller.js": {
  \       "type": "stimulus",
  \       "template": ["import {open} Controller {close} from 'stimulus'", "", "export default class extends Controller {", "", "  static targets = []", "", "}"]
  \     },
  \     "config/*": {
  \       "type": "config"
  \     },
  \   },
  \   "plugin/": {
  \     "plugin/*.vim": {
  \       "type": "plugin"
  \     },
  \     "autoload/*.vim": {
  \       "type": "autoload"
  \     },
  \     "doc/*.text": {
  \       "type": "doc"
  \     },
  \   }
  \ }


" vim-dirvish
" sort directories before files, alphabetical
let g:dirvish_mode = ':sort /^.*[\/]/'  " from dirvish faq
augroup my_dirvish_events
  autocmd!

  " Map `gh` to hide dotfiles.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer> gh :silent :keeppatterns g@\v/\.[^\/]+/?$@d<cr>

  autocmd FileType dirvish nnoremap <buffer> + :edit %
augroup END


" vim-illuminate
let g:Illuminate_highlightUnderCursor = 0
let g:Illuminate_delay = 5000


" indentLine
let g:indentLine_char = '⋮'  " ¦
let g:indentLine_fileType = ['slim', 'sass']
let g:indentLine_setColors = 0
highlight! link Conceal EndOfBuffer



" vim-prettier
let g:prettier#autoformat=0
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'none'
" autocmd BufWritePost *.js,*.json Prettier


" Create directories as needed when writing files.
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')


iab DA DoubleAgent
iab FA FreeAgent
iab GC GoCardless
iab tx transaction


let g:dash_scopes = {
      \ 'ruby': 'r',
      \ 'javascript': 'js',
      \ 'css': 'css',
      \ }
command! Dash call SearchDash(g:dash_scopes[&filetype])
function SearchDash(scope)
  let url = 'dash://'.a:scope.':'.expand('<cword>')
  call system('open '.url)
endfunction


" fzf.vim
set rtp+=/usr/local/opt/fzf
map <leader>f :Files<CR>
let g:fzf_layout = { 'window': {
                \ 'width': 0.9,
                \ 'height': 0.7,
                \ 'highlight': 'Comment',
                \ 'border': 'sharp' } }


" git-messenger
let g:git_messenger_preview_mods = 'botright'
" Stop the preview window closing immediately (unexplained interaction with vim-gitgutter):
" https://github.com/rhysd/git-messenger.vim/issues/54
let g:git_messenger_close_on_cursor_moved = v:false


" vim-test
nmap <silent> <Leader>tt :wa\|:TestNearest<CR>
nmap <silent> <Leader>tf :wa\|:TestFile<CR>
let test#strategy = 'iterm'  " basic | vimterminal
let g:test#preserve_screen = 1
