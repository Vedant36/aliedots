" custom *bnf syntax file
" written by Vedant36
" Vim syntax file
" Language:         Generic log file
" Maintainer:       Vedant36 <vedantneema@gmail.com>
" Latest Revision:  2020-08-23
if exists('b:current_syntax')
  finish
endif

syntax clear
syntax match Conditional /|/
syntax match Function /^\s\+/
syntax match Comment /^;.*/
syntax match String /'.\{-\}'/
syntax match String /".\{-\}"/
syntax match String /`.\{-\}`/
syntax match Type / [^|'"`:={}()\[\]]\+\>/
" syn keyword bnfOperator { } ( ) ::= =
syntax match Operator /\(=\|::=\)/
syntax match Identifier /^\S[^;:=\n]\+ /

" hi link bnfOperator Operator

let b:current_syntax = 'bnf'
