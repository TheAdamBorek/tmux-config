#!/bin/bash
terminal_pane_name='terminal'
terminal_pane_index=$( tmux lsp -F 'Index: #P Title: #T' | (rg $terminal_pane_name || echo "-1") | awk '{if ($2 ~ /^[0-9]+$/) print $2; else print "-1"}')
current_pane_index=$( tmux display-message -p '#P' )
current_pane_zoomed=$( tmux display-message -p '#{?pane_zoomed,1,0}' )

if [ $terminal_pane_index -eq -1 ]; then
    tmux split-window -v -l 33%
    tmux select-pane -T $terminal_pane_name
    exit 0
fi

if [ $current_pane_index -eq $terminal_pane_index ]; then
    tmux select-pane -U
    tmux resize-pane -Z
    exit 0
fi

if [ $current_pane_zoomed -eq 0 ]; then
    tmux resize-pane -Z
    exit 0
fi

tmux select-pane -t $terminal_pane_index
