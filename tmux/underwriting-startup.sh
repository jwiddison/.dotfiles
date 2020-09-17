#!/bin/bash

SESSION="Underwriting"
SESSIONEXISTS=$(tmux list-sessions | grep "${SESSION}")

if [ "$SESSIONEXISTS" = "" ]
then
  tmux new-session -d -s "${SESSION}"

  tmux rename-window -t 0 " "
  tmux send-keys -t " " "underwriting" C-m "clear" C-m "v" C-m

  tmux new-window -t "${SESSION}":1 -n " "
  tmux send-keys -t " " "underwriting" C-m "clear" C-m

  tmux new-window -t "${SESSION}":2 -n "  - Juno"
  tmux send-keys -t "  - Juno" "juno" C-m "clear" C-m "v" C-m

  tmux new-window -t "${SESSION}":3 -n "  - Juno"
  tmux send-keys -t "  - Juno" "juno" C-m

  # tmux new-window -t "${SESSION}":2 -n "Onboarding"
  # tmux send-keys -t "Onboarding" "onboarding" C-m "clear" C-m

  # tmux new-window -t "${SESSION}":3 -n "TEAMSPACES"
  # tmux send-keys -t "TEAMSPACES" "clear" C-m
fi

tmux attach-session -t "${SESSION}":0
