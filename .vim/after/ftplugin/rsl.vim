setlocal indentkeys=!^F,o,O,=in,=do,=is
setlocal indentexpr=GetRSLIndent(v:lnum)


function! GetRSLIndent(lnum)
  if a:lnum == 1
    return 0
  endif
  let thisline = getline(a:lnum)

  if thisline =~ '^\s*variable'
    return 2
  endif

  if thisline =~ '^\s*value'
    return 2
  endif

  if thisline =~ '^\s*type'
    return 2
  endif

  if thisline =~ '^\s*--'
    return 0
  endif

  let prevlnum = prevnonblank(a:lnum - 1)
  let prevline = getline(prevlnum)
  let previndent = indent(prevlnum)


  if prevline =~ 'do$'
    return previndent + 2
  endif

  if prevline =~ 'of$'
    return previndent + 2
  endif

  if prevline =~ 'is$'
    return previndent + 2
  endif

  if prevline =~ '\Win$'
    return previndent + 2
  endif

  "if prevline =~ '^\s*value'
    "return previndent + 2
  "endif

  if prevline =~ 'then$'
    return previndent + 2
  endif

  if prevline =~ 'else$'
    return previndent + 2
  endif

  if thisline =~ 'until$'
    return previndent - 2
  endif

  if thisline =~ 'else$'
    return previndent - 2
  endif

  if prevline =~ 'until$'
    return previndent + 2
  endif

  if prevline =~ ';$'
    return previndent
  endif

  if thisline =~ '^\s*end'
    return previndent - 2
  endif

  return previndent
endfunction
