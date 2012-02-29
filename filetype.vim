" Set filetypes which haven't got their own syntax/indent/plugin files.

if exists("did_load_my_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.ncss setfiletype css
  au! BufRead,BufNewFile */nginx/*.conf set ft=nginx
augroup END
