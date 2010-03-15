augroup filetypedetect
au BufNewFile,BufRead *.plist setfiletype plist
augroup END

au BufNewFile,BufRead *.ncss setfiletype css

au BufNewFile,BufRead *.textile setfiletype textile

au BufNewFile,Bufread *.rake,[rR]akefile,*.prawn setfiletype ruby

" http://plasticboy.com/markdown-vim-mode/
augroup markdown
au! BufRead,BufNewFile *.mkd setfiletype mkd
augroup END

au BufRead,BufNewFile *.haml setfiletype haml

au BufRead *.tex setfiletype tex
