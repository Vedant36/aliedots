if exists('b:current_syntax')
  finish
endif

syntax clear
syntax match Repeat /[\[\]]/
syntax match Number /[+-]/
syntax match Function /[,.]/
syntax match StorageClass /[<>]/
syntax match Comment /[^\[\]<>,.+-]/

let b:current_syntax = 'brainfuck'
