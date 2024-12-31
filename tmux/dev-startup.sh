#!/bin/sh

set SESSION "Dev"
set SESSIONEXISTS $(tmux list-sessions | grep $SESSION)

cd ~/Dev/

if [ "$SESSIONEXISTS" = "" ]
  tmux new-session -d -s $SESSION

  # Make window titles be the working directory
  tmux set-option -g status-interval 5
  tmux set-option -g automatic-rename on
  tmux set-option -g automatic-rename-format '#{b:pane_current_path}'

  tmux send-keys -t 0 "dev" C-m "clear" C-m
  tmux send-keys -t $SESSION:1 "dev" C-m "clear" C-m
end

tmux attach-session -t $SESSION:0
