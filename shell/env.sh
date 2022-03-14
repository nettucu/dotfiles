# XDG compliant directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}

# totally dislike nano :)
command -v nvim >/dev/null 2>&1 && export EDITOR="nvim" || export EDITOR="vim"
export VISUAL="${EDITOR}"

# dircolors
eval $( dircolors ~/.dotfiles/LS_COLORS/LS_COLORS )

# fd find replacement options
export FD_OPTIONS="--follow --exclude .git"

# fuzzy search options
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info \
    --preview='[[ \$( file --mime {} ) =~ binary ]] && echo {} is a binary file || ( bat --style=numbers --colors=always {} || cat {} ) 2>/dev/null | head -300' \
    --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy )'"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

# bat = cat replacement
export BAT_PAGER="less -R"

# CHROOT for AUR
export CHROOT=/home/catalin/work/arch/chroot
