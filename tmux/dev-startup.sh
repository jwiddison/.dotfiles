#!/bin/bash

SESSION="Dev"
SESSIONEXISTS=$(tmux list-sessions | grep "${SESSION}")

cd ~/Dev/

if [ "$SESSIONEXISTS" = "" ]
then
  tmux new-session -d -s "${SESSION}"

  tmux rename-window -t 0 " "
  tmux send-keys -t " " "dev" C-m "clear" C-m

  tmux new-window -t "${SESSION}":1 -n " "
  tmux send-keys -t " " "dev" C-m "clear" C-m
fi

tmux attach-session -t "${SESSION}":0
