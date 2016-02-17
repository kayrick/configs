" Vim filetype plugin file for GNU-C coding style
" Language:	C
" Maintainer:	Dean Scarff <p00ya @AT users.sf .DOT net>
" Last Change:	2005 Feb 09

" USAGE: Copy to an ftplugin directory, see |ftplugin-overrule|.

" Overrules any previous ftplugin, and flags to not load further ftplugins
let b:did_ftplugin = 1

" Set various width parameters
setlocal sw=4 ts=8 tw=78

setlocal cinoptions=g0:0(0

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:\ \ \ ,exO:*/,s1:/*,mb:\ ,ex:*/

set cpo-=C

