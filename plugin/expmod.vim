" Author:	Mikolaj Machowski <mikmach@wp.pl
" Version:	0.3
" Description:	Extension supporting modified explorer
" Installation: Drop it into your plugin directory
" Last Change: nie sie 11 12:00  2002 C
" Thanks to: Benji Fisher for Common() fun! Available also in the newest
" version of foo.vim


nnoremap <F8> :call Gfile(g:alenazwapliku)<cr>


function! Common(path1, path2)
	" Assume the caller handles 'ignorecase'
	if a:path1 == a:path2
		return a:path1
	endif
	let n = 0
	while a:path1[n] == a:path2[n]
		let n = n+1
	endwhile
	return strpart(a:path1, 0, n)
endfunction

function! Gfile(filename)
	let s:shortfilename = fnamemodify(a:filename, ':p:tr')
	let path1 = a:filename
	let path2 = expand("%:p")
	if has("win32")
		let path1 = substitute(path1, "\\", "/", "ge")
		let path2 = substitute(path2, "\\", "/", "ge")
	endif
	let n = matchend(Common(path1, path2), '.*/')
	let path1 = strpart(path1, n)
	let path2 = strpart(path2, n)
	if path2 !~ '/'
		let subrelpath = ""
	else
		let subrelpath = substitute(path2, '[^/]\{-}/', '../', 'ge')
		let subrelpath = substitute(subrelpath, '[^/]*$', '', 'ge')
	endif
	let relpath = subrelpath.path1
	if &filetype == "html"
		if a:filename =~ "gif$\\|jpg$\\|png$"
			let filedata = system("identify ".a:filename)
			let dimensions = matchstr(filedata, ' \zs\d.\{-}\d\ze ')
			let width = matchstr(dimensions, '^[^x]\{-}\zex')
			let height = matchstr(dimensions, 'x\zs\d\{-}\ze\(\D\|$\)')
			let returnstring = '<img src="'.relpath.'" width="'.width.
			\ '" height="'.height.'" border="0" alt="'.s:shortfilename.'">'
		else
			let returnstring = '<a href="'.relpath.'" class="">'
		endif
	elseif &filetype == "php"
		let returnstring = 'include "'.relpath.'";'
	elseif &filetype == "cpp" || &filetype == "c"
		let returnstring = '#include <'.relpath.'>'
	endif
	if exists("returnstring")
		put = returnstring
	endif
endfunction
