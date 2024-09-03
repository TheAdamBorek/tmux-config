#!/bin/bash

top_position=$(tmux display-message -p "#{pane_top}")
panes_above=$(tmux list-panes -F "#{pane_top}" | awk -v top=$top_position '$1 < top')

if [ ! -z "$panes_above" ]; then 
    tmux select-pane -U
    tmux resize-pane -Z
fi

