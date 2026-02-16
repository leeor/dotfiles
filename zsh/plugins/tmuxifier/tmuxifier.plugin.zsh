if [[ -f "${HOME}/.tmuxifier/bin/tmuxifier" ]]; then
    export PATH="$PATH:${HOME}/.tmuxifier/bin"
    eval "$(tmuxifier init -)"
fi

# tmux aliases
alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tns='tmux new-session -s'
alias tks='tmux kill-session -t'
alias tka='tmux kill-server'
