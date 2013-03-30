function SetLocalTags(fname)
	let dirname = fnamemodify(a:fname, ":p:h")
	while "/" != dirname
		let ltags  = dirname . "/tags"
		if filereadable(ltags)
			execute ":set tags+=".ltags
		endif
		let dirname = fnamemodify(dirname, ":p:h:h")
	endwhile
endfunction

au BufNewFile,BufRead * call SetLocalTags(bufname("%"))

