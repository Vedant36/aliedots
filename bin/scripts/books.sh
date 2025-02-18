#!/usr/bin/env bash
pushd "$HOME" >/dev/null || exit "$ENOTDIR";
book="$(find dox/{allbooks,college,oldbooks} pix/{cheatsheets,documents} -type f | sort -n | dmenu -i)"
popd >/dev/null || exit "$ENOTDIR";
[ "$book" ] && xdg-open ~/"$book"
