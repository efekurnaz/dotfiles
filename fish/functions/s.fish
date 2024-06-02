function s
	set -l WINDOW_NAME (basename $PWD)
	tmux rename-window $WINDOW_NAME
	tmux split-window -h -l 30%
	tmux split-window -v -l 20%
  sleep 0.5
	tmux send-keys -t 2 'yarn shopify:serve' C-m
	tmux send-keys -t 3 'yarn tailwind:watch' C-m
	tmux send-keys -t 1 'nvim .' C-m
	tmux select-pane -t 1
end
