function nv3
	set -l WINDOW_NAME (basename $PWD)
	tmux rename-window $WINDOW_NAME
	tmux split-window -v -b -l 9
	tmux split-window -h -l 30%
	tmux send-keys -t 1 'ngrok http 3000' C-m
	tmux send-keys -t 2 'yarn dev' C-m
	tmux send-keys -t 3 'nvim .' C-m
	tmux select-pane -t 3
end

