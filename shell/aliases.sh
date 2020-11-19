alias ls='ls --group-directories-first --color=auto -F'

# replace cat with bat if installed
command -v bat >/dev/null 2>&1 && alias cat='bat'

# some features are missing so not replacing
#command -v fd >/dev/null 2>&1 && alias find="fd -H"
#[[ $SHELL == *zsh ]] && command -v fd >/dev/null 2>&1 && alias find="noglob fd -H"
