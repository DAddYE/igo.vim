" Copyright 2009 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
" igo.vim: Vim syntax file for iGo.
"
" Options:
"   There are some options for customizing the highlighting; the recommended
"   settings are the default values, but you can write:
"     let OPTION_NAME = 0
"   in your ~/.vimrc file to disable particular options. You can also write:
"     let OPTION_NAME = 1
"   to enable particular options. At present, all options default to on.
"
"   - igo_highlight_array_whitespace_error
"     Highlights white space after "[]".
"   - igo_highlight_chan_whitespace_error
"     Highlights white space around the communications operator that don't follow
"     the standard style.
"   - igo_highlight_extra_types
"     Highlights commonly used library types (io.Reader, etc.).
"   - igo_highlight_space_tab_error
"     Highlights instances of tabs following spaces.
"   - igo_highlight_trailing_whitespace_error
"     Highlights trailing white space.

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

if !exists("igo_highlight_array_whitespace_error")
  let igo_highlight_array_whitespace_error = 1
endif
if !exists("igo_highlight_chan_whitespace_error")
  let igo_highlight_chan_whitespace_error = 1
endif
if !exists("igo_highlight_extra_types")
  let igo_highlight_extra_types = 1
endif
if !exists("igo_highlight_space_tab_error")
  let igo_highlight_space_tab_error = 1
endif
if !exists("igo_highlight_trailing_whitespace_error")
  let igo_highlight_trailing_whitespace_error = 1
endif

syn case match

syn keyword     igoDirective         package import
syn keyword     igoDeclaration       var const type
syn keyword     igoDeclType          struct interface
syn keyword     igoSelf              self

hi def link     igoDirective         Statement
hi def link     igoDeclaration       Keyword
hi def link     igoDeclType          Keyword
hi def link     igoSelf              Identifier

" Keywords within functions
syn keyword     igoStatement         defer go goto return break continue fallthrough
syn keyword     igoConditional       if else switch select
syn keyword     igoLabel             case default
syn keyword     igoRepeat            for range

hi def link     igoStatement         Statement
hi def link     igoConditional       Conditional
hi def link     igoLabel             Label
hi def link     igoRepeat            Repeat

" Predefined types
syn keyword     igoType              chan map bool string error
syn keyword     igoSignedInts        int int8 int16 int32 int64 rune
syn keyword     igoUnsignedInts      byte uint uint8 uint16 uint32 uint64 uintptr
syn keyword     igoFloats            float32 float64
syn keyword     igoComplexes         complex64 complex128

hi def link     igoType              Type
hi def link     igoSignedInts        Type
hi def link     igoUnsignedInts      Type
hi def link     igoFloats            Type
hi def link     igoComplexes         Type

" Treat func and do specially: it's a declaration at the start of a line, but a type
" elsewhere. Order matters here.
syn match       igoType              /\<func\>/
syn match       igoDeclaration       /^func\>/
syn match       igoType              /\<do\>/
syn match       igoDeclaration       /^do\>/

" Predefined functions and values
syn keyword     igoBuiltins          append cap close complex copy delete imag len
syn keyword     igoBuiltins          make new panic print println real recover
syn keyword     igoConstants         iota true false nil

hi def link     igoBuiltins          Keyword
hi def link     igoConstants         Keyword

" Comments; their contents
syn keyword     igoTodo              contained TODO FIXME XXX BUG
syn cluster     igoCommentGroup      contains=igoTodo
syn region      igoComment           start="#" end="$" contains=@igoCommentGroup,@Spell

hi def link     igoComment           Comment
hi def link     igoTodo              Todo

" Go escapes
syn match       igoEscapeOctal       display contained "\\[0-7]\{3}"
syn match       igoEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       igoEscapeX           display contained "\\x\x\{2}"
syn match       igoEscapeU           display contained "\\u\x\{4}"
syn match       igoEscapeBigU        display contained "\\U\x\{8}"
syn match       igoEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     igoEscapeOctal       igoSpecialString
hi def link     igoEscapeC           igoSpecialString
hi def link     igoEscapeX           igoSpecialString
hi def link     igoEscapeU           igoSpecialString
hi def link     igoEscapeBigU        igoSpecialString
hi def link     igoSpecialString     Special
hi def link     igoEscapeError       Error

" Strings and their contents
syn cluster     igoStringGroup       contains=igoEscapeOctal,igoEscapeC,igoEscapeX,igoEscapeU,igoEscapeBigU,igoEscapeError
syn region      igoString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@igoStringGroup
syn region      igoRawString         start=+`+ end=+`+

hi def link     igoString            String
hi def link     igoRawString         String

" Characters; their contents
syn cluster     igoCharacterGroup    contains=igoEscapeOctal,igoEscapeC,igoEscapeX,igoEscapeU,igoEscapeBigU
syn region      igoCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@igoCharacterGroup

hi def link     igoCharacter         Character

" Regions
syn region      igoBlock             start="{" end="}" transparent fold
syn region      igoParen             start='(' end=')' transparent

" Integers
syn match       igoDecimalInt        "\<\d\+\([Ee]\d\+\)\?\>"
syn match       igoHexadecimalInt    "\<0x\x\+\>"
syn match       igoOctalInt          "\<0\o\+\>"
syn match       igoOctalError        "\<0\o*[89]\d*\>"

hi def link     igoDecimalInt        Integer
hi def link     igoHexadecimalInt    Integer
hi def link     igoOctalInt          Integer
hi def link     Integer              Number

" Floating point
syn match       igoFloat             "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match       igoFloat             "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match       igoFloat             "\<\d\+[Ee][-+]\d\+\>"

hi def link     igoFloat             Float

" Imaginary literals
syn match       igoImaginary         "\<\d\+i\>"
syn match       igoImaginary         "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syn match       igoImaginary         "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syn match       igoImaginary         "\<\d\+[Ee][-+]\d\+i\>"

hi def link     igoImaginary         Number

" Spaces after "[]"
if igo_highlight_array_whitespace_error != 0
  syn match igoSpaceError display "\(\[\]\)\@<=\s\+"
endif

" Spacing errors around the 'chan' keyword
if igo_highlight_chan_whitespace_error != 0
  " receive-only annotation on chan type
  syn match igoSpaceError display "\(<-\)\@<=\s\+\(chan\>\)\@="
  " send-only annotation on chan type
  syn match igoSpaceError display "\(\<chan\)\@<=\s\+\(<-\)\@="
  " value-ignoring receives in a few contexts
  syn match igoSpaceError display "\(\(^\|[={(,;]\)\s*<-\)\@<=\s\+"
endif

" Extra types commonly seen
if igo_highlight_extra_types != 0
  syn match igoExtraType /\<bytes\.\(Buffer\)\>/
  syn match igoExtraType /\<io\.\(Reader\|Writer\|ReadWriter\|ReadWriteCloser\)\>/
  syn match igoExtraType /\<reflect\.\(Kind\|Type\|Value\)\>/
  syn match igoExtraType /\<unsafe\.Pointer\>/
endif

" Space-tab error
if igo_highlight_space_tab_error != 0
  syn match igoSpaceError display " \+\t"me=e-1
endif

" Trailing white space error
if igo_highlight_trailing_whitespace_error != 0
  syn match igoSpaceError display excludenl "\s\+$"
endif

hi def link     igoExtraType         Type
hi def link     igoSpaceError        Error

" Search backwards for a global declaration to start processing the syntax.
"syn sync match igoSync grouphere NONE /^\(const\|var\|type\|func\)\>/

" There's a bug in the implementation of grouphere. For now, use the
" following as a more expensive/less precise workaround.
syn sync minlines=500

let b:current_syntax = "igo"
