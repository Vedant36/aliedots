#!/usr/bin/env bash
pushd "$HOME" >/dev/null || exit "$ENOTDIR";
book="$(find dox/{allbooks,college,oldbooks,imp_docs} pix/{cheatsheets,documents} -type f | sort -n | dmenu -i -z 1000)"
popd >/dev/null || exit "$ENOTDIR";
[ "$book" ] && xdg-open ~/"$book"
