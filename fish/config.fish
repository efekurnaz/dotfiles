set -gx EDITOR nvim

#set -gx FZF_CTRL_T_COMMAND vim
set -gx FZF_DEFAULT_OPS --extended
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-file "~/.config/.ignore"'

status --is-interactive; and source (jump shell fish | psub)

set fish_cursor_unknown block blink
# don't show any greetings

set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end
