if exists('b:current_syntax')
  finish
endif

syntax clear
syntax match String /^>.*$/
syntax match ErrorMsg />>\d\+/

let b:current_syntax = '4chan'
