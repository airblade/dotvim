" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:plist_cpo_save = &cpo
set cpo&vim

runtime! syntax/xml.vim

syn case ignore

let b:current_syntax = "plist"

let &cpo = s:plist_cpo_save
unlet s:plist_cpo_save
