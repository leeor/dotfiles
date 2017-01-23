if [[ -f "${HOME}/.tmuxifier/bin/tmuxifier" ]]; then
    export PATH="$PATH:${HOME}/.tmuxifier/bin"
    eval "$(tmuxifier init -)"
    alias tmux='export TERM=screen-256color && tmux -2 '
fi
