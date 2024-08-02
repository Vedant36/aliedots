#!/bin/bash

search_term=`xsel`
search_url="https://www.duckduckgo.com/$search_term"
xdg-open "$search_url"
