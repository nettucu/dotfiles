# vim: ft=zsh sw=4
source ~/.dotfiles/shell/functions.sh

source ~/.dotfiles/shell/env.sh

export ANTIDOTE_HOME=~/.dotfiles/antidote
source "${ANTIDOTE_HOME}/antidote.zsh"

zstyle ':antidote:bundle' use-friendly-names 'yes'

zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:git:alias' skip 'yes'
zstyle ':prezto:module:python:virtualenv' initialize 'off'
zstyle ':prezto:module:python:conda' initialize 'off'
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_dsa' 'id_rsa_github_ctrifu' 'id_rsa_dentrix.ro' 'id_ed25519_github_ctrifu'

antidote load ${HOME}/.dotfiles/zsh_plugins.txt

# Override Zephyr/Prezto history settings to share history between sessions.
setopt share_history
setopt append_history
setopt inc_append_history

os="$( uname )"
if [[ ${os} == "Linux" ]]; then
  osrel="$(grep '^ID=' /etc/os-release | cut -d'=' -f2)"
  case ${osrel} in
    arch)   eval "$(antidote bundle sorin-ionescu/prezto path:modules/pacman)" ;;
    fedora) eval "$(antidote bundle sorin-ionescu/prezto path:modules/dnf)" ;;
  esac
fi

source ~/.dotfiles/shell/aliases.sh

source ~/.dotfiles/shell/path.sh

# source Node.js nvm stuff if needed
if [[ -r /usr/share/nvm/init-nvm.sh ]]; then
    source /usr/share/nvm/init-nvm.sh
fi

_dotnet_zsh_complete()
{
    local completions=("$(dotnet complete "$words")")

    reply=( "${(ps:\n:)completions}" )
}

if [[ -f /opt/google-cloud-cli/completion.zsh.inc ]]; then
    source /opt/google-cloud-cli/completion.zsh.inc
fi

compctl -K _dotnet_zsh_complete dotnet

eval "$( starship init zsh )"

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f "${HOME}/.config/.dart-cli-completion/zsh-config.zsh" ]] && . "${HOME}/.config/.dart-cli-completion/zsh-config.zsh" || true
## [/Completion]


# Added by LM Studio CLI (lms)
[[ -f "${HOME}/.lmstudio/bin/lms" ]] && export PATH="$PATH:${HOME}/.lmstudio/bin"
# End of LM Studio CLI section


# opencode
[[ -d "${HOME}/.opencode/bin" ]] && export PATH="${HOME}/.opencode/bin:$PATH"

# clawdock
# source ~/.clawdock/clawdock-helpers.sh
# export CLAWDOCK_DIR=${HOME}/work/openclaw

if [[ -f ${HOME}/.local/bin/env ]]; then
    source "${HOME}/.local/bin/env"
fi

if command -v fnm >/dev/null 2>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
