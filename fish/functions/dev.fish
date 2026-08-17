function dev --description 'Instant jump to dev folders'
    if test (count $argv) -eq 0
        echo "Usage: dev <folder_name>"
        return 1
    end
    
    set -l target_dir (find $HOME/dev -name node_modules -prune -o -type d -iname "*$argv[1]*" -print -quit)
    
    if test -n "$target_dir"
        cd "$target_dir"
    else
        echo "No folder matching '$argv[1]' found in dev."
    end
end
