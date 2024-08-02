#!/usr/bin/env bash
pushd "$HOME/dox" >/dev/null || exit "$ENOTDIR";
book="$(find {oldbooks,allbooks,college} -type f | dmenu -i)"
popd >/dev/null || exit "$ENOTDIR";
[ "$book" ] && zathura ~/dox/"$book"
