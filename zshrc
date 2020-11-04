# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZGEN_DIR=~/.dotfiles/zgen
source "${ZGEN_DIR}/zgen.zsh"

if ! zgen saved; then
    zgen prezto editor key-bindings 'emacs'
    zgen prezto prompt theme 'powerlevel10k'
    zgen prezto git 'alias:skip' 'yes'

    zgen prezto
    zgen prezto git
    zgen prezto command-not-found
    zgen prezto syntax-highlighting
    zgen prezto utility
    zgen prezto completion
    osrel="$( cat /etc/os-release | grep '^ID=' | cut -d'=' -f2 )"
    case ${osrel} in
        arch) zgen prezto pacman ;;
        fedora) zgen prezto dnf ;;
    esac
fi

# Customize to your needs...

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
