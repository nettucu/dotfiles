source $HOME/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Added by LM Studio CLI (lms)
[[ -f "${HOME}/.lmstudio/bin/lms" ]] && export PATH="$PATH:${HOME}/.lmstudio/bin"
# End of LM Studio CLI section
