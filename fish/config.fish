set -gx EDITOR nvim

#set -gx FZF_CTRL_T_COMMAND vim
set -gx FZF_DEFAULT_OPS --extended
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-file "~/.config/.ignore"'

status --is-interactive; and source (jump shell fish | psub)

set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set fish_cursor_unknown block blink

# don't show any greetings
set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_default_key_bindings -M insert
fish_vi_key_bindings --no-erase insert

# Just clear the commandline on control-c
bind \cc 'commandline -r ""'
