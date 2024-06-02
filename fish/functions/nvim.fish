function nvim
    set -l dir (basename (pwd))
    tmux rename-window $dir
    command nvim $argv
end
