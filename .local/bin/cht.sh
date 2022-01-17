#!/usr/bin/env bash

languages=$(echo "golang c cpp typescript rust javascript")
core_utils=$(echo "find xargs sed awk")
selected=$(echo -e "$languages\n$core_utils" | tr " " "\n" | fzf)

read -p "Query: " query

if echo "$languages" | grep -qs $selected; then
    tmux split-window -h bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less"
else
    curl cht.sh/$selected~$query
fi
