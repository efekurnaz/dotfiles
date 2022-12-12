function c
	tmux rename-window config
	tmux send-keys -t 1 'nvim ~/.config/nvim/init.vim ~/.config/tmux/tmux.conf ~/.config/kitty/efe.conf ~/.config/fish/config.fish ~/.config/tmux/plugins/tmux/scripts/dracula.sh' C-m
end
