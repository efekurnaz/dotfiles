function s
	set -l WINDOW_NAME (basename $PWD)
	tmux rename-window $WINDOW_NAME
	tmux split-window -v -b -l 9
	tmux split-window -h -l 30%
  sleep 0.5
	tmux send-keys -t 1 'yarn shopify:serve' C-m
	tmux send-keys -t 2 'yarn tailwind:watch' C-m
	tmux send-keys -t 3 'nvim .' C-m
	tmux select-pane -t 3
end
