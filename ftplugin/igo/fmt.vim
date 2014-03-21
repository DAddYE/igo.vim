" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
" fmt.vim: Vim command to format iGo files with igo fmt.
"
" This filetype plugin add a new commands for go buffers:
"
"   :Ifmt
"
"       Filter the current Go buffer through gofmt.
"       It tries to preserve cursor position and avoids
"       replacing the buffer with stderr output.
"
" if exists("b:did_ftplugin_igo_fmt")
"     finish
" endif

" command! -buffer Ifmt call s:IgoFormat()

" function! s:IgoFormat()
"     let view = winsaveview()
"     silent %!igo fmt
"     if v:shell_error
"         let errors = []
"         for line in getline(1, line('$'))
"             let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
"             if !empty(tokens)
"                 call add(errors, {"filename": @%,
"                                  \"lnum":     tokens[2],
"                                  \"col":      tokens[3],
"                                  \"text":     tokens[4]})
"             endif
"         endfor
"         if empty(errors)
"             % | " Couldn't detect gofmt error format, output errors
"         endif
"         undo
"         if !empty(errors)
"             call setloclist(0, errors, 'r')
"         endif
"         echohl Error | echomsg "igo fmt returned error" | echohl None
"     endif
"     call winrestview(view)
" endfunction

" let b:did_ftplugin_igo_fmt = 1

" vim:ts=4:sw=4:et
