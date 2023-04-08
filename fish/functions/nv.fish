function nv
	set -l WINDOW_NAME (basename $PWD)
	tmux rename-window $WINDOW_NAME
	tmux send-keys -t 1 'nvim .' C-m
end

