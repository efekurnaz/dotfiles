function doc --description 'Instant jump to Efeos folders'
    if test (count $argv) -eq 0
        echo "Usage: doc <folder_name>"
        return 1
    end
    
    set -l target_dir (find $HOME/Documents/Efeos -name node_modules -prune -o -type d -iname "*$argv[1]*" -print -quit)
    
    if test -n "$target_dir"
        cd "$target_dir"
    else
        echo "No folder matching '$argv[1]' found in Efeos."
    end
end
