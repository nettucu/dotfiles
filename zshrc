# vim: ft=zsh sw=4
source ~/.dotfiles/shell/functions.sh

source ~/.dotfiles/shell/env.sh

# eval "$( starship init zsh )"

# return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export ZGEN_DIR=~/.dotfiles/zgen
source "${ZGEN_DIR}/zgen.zsh"

if ! zgen saved; then
    zgen prezto editor key-bindings 'emacs'
    # zgen prezto prompt theme 'powerlevel10k'
    zgen prezto 'git:alias' skip 'yes'

    zgen prezto
    zgen prezto git
    zgen prezto command-not-found
    zgen prezto syntax-highlighting
    zgen prezto utility
    zgen prezto completion
    zgen prezto docker
    zgen prezto python skip-virtualenvwrapper-init 'on'
    zgen prezto conda-init 'off'
    zgen prezto python
    zgen prezto ssh 'id_rsa' 'id_dsa' 'id_rsa_github_ctrifu' 'id_rsa_dentrix.ro'
    zgen prezto ssh
    osrel="$( cat /etc/os-release | grep '^ID=' | cut -d'=' -f2 )"
    case ${osrel} in
        arch) zgen prezto pacman ;;
        fedora) zgen prezto dnf ;;
    esac

    zgen save
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$( starship init zsh )"

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/catalin/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/catalin/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/catalin/.lmstudio/bin"
# End of LM Studio CLI section


# opencode
export PATH=/home/catalin/.opencode/bin:$PATH

# clawdock
# source ~/.clawdock/clawdock-helpers.sh
# export CLAWDOCK_DIR=/home/catalin/work/openclaw

if [[ -f ${HOME}/.local/bin/env ]]; then
    source "${HOME}/.local/bin/env"
fi
