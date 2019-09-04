" Highlight trailing full stop in commit summary as an error.


syn match gitcommitTrailingFullStop "\.$" contained

" Override existing syntax match so it can contain my match.
" https://github.com/tpope/vim-git/blob/ca2645abf96f6f6daaef55dbfaf64f7f77713150/syntax/gitcommit.vim#L21
syn match gitcommitSummary  "^.*\%<51v." contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell,gitcommitTrailingFullStop

hi def link gitcommitTrailingFullStop Error
