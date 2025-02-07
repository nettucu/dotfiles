# vim: ft=zsh sw=2 ts=2 sts=2 et
if command -v lsd >/dev/null 2>&1; then
  alias ls='lsd --group-directories-first -F'
else
  alias ls='ls --group-directories-first --color=auto -F'
fi

alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# replace cat with bat if installed
command -v bat >/dev/null 2>&1 && alias cat='bat'

# some features are missing so not replacing
#command -v fd >/dev/null 2>&1 && alias find="fd -H"
[[ $SHELL == *zsh ]] && command -v fd >/dev/null 2>&1 && alias find="noglob fd -H"

# if we use kitty as terminal then we want to use the kitty specific aliases
if [[ "$TERM" = "xterm-kitty" ]]; then
  alias d="kitten diff"
  alias ssh="kitty +kitten ssh"
  alias icat="kitty +kitten icat"
fi
