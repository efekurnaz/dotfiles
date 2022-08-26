function c
	tmux rename-window config
	tmux send-keys -t 1 'nvim ~/.config/nvim/init.vim'
	tmux send-keys -t 1 ':e ~/.config/tmux/tmux.conf'
	tmux send-keys -t 1 ':e ~/.config/alacritty/alacritty.yml'
	tmux send-keys -t 1 ':e ~/.config/fish/config.fish'
end
