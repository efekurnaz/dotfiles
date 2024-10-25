function s
    set -l WINDOW_NAME (basename $PWD)
    tmux rename-window $WINDOW_NAME
    # First split horizontally (into rows) with bottom being 80%
    tmux split-window -v -l 90%
    # Then split the top pane vertically (into columns) with right being 20%
    tmux split-window -h -l 20% -t 1
    sleep 0.5
    tmux send-keys -t 2 'yarn tailwind:watch' C-m
    tmux send-keys -t 1 'yarn shopify:serve' C-m
    tmux send-keys -t 3 'nvim .' C-m
    tmux select-pane -t 3
end
