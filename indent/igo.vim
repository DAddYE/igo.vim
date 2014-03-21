" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
" indent/igo.vim: Vim indent file for iGo.
"
" TODO:
" - function invocations split across lines
" - general line splits (line ends in an operator)

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

" C indentation is too far off useful, mainly due to Go's := operator.
" Let's just define our own.
setlocal nolisp
setlocal autoindent
setlocal indentexpr=IgoIndent(v:lnum)
setlocal indentkeys+=<:>,0=},0=)

if exists("*IgoIndent")
  finish
endif

function! IgoIndent(lnum)
  let prevlnum = prevnonblank(a:lnum-1)
  if prevlnum == 0
    " top of file
    return 0
  endif

  " grab the previous and current line, stripping comments.
  let prevl = substitute(getline(prevlnum), '#.*$', '', '')
  let thisl = substitute(getline(a:lnum), '#.*$', '', '')
  let previ = indent(prevlnum)

  let ind = previ

  if prevl =~ '[({]\s*$'
    " previous line opened a block
    let ind += &sw
  endif

  if prevl =~ '^\s*\(import\|const\|type\|var\|func\|if\|for\|switch\)\>'
    " This is a benign line, do nothing
    let ind += &sw
  endif

  if thisl =~ '^\s*\(}\|)\|else\)'
    " this line closed a block
    let ind -= &sw
  endif

  return ind
endfunction
