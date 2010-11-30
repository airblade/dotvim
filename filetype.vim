" Set filetypes which haven't got their own syntax/indent/plugin files.

if exists("did_load_my_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.ncss setfiletype css
augroup END
