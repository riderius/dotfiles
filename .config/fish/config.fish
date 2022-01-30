set fish_greeting
set EDITOR /usr/bin/emacs -nw
set LESSOPEN "|lesspipe.sh %s"; export LESSOPEN

alias emacs "emacsclient -nw -a 'emacs --daemon'"

