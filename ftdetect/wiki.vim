" Taken from http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim
" Ian Tegebo <ian.tegebo@gmail.com>

augroup filetypedetect
	au BufRead,BufNewFile *.wiki setf dokuwiki
augroup END


augroup filetypedetect
	autocmd BufRead,BufNewFile *.wik setfiletype Wikipedia
	autocmd BufRead,BufNewFile *.wikipedia.org* setfiletype Wikipedia
augroup END

