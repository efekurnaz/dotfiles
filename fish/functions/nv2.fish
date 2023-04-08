function nv2
	set -l WINDOW_NAME (basename $PWD)
	tmux rename-window $WINDOW_NAME
	tmux split-window -v -b -l 9
	tmux send-keys -t 1 'yarn dev' C-m
	tmux send-keys -t 2 'nvim .' C-m
	tmux select-pane -t 2
end

