# XDG compliant directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}

# totally dislike nano :)
command -v nvim >/dev/null 2>&1 && export EDITOR="nvim" || export EDITOR="vim"
export VISUAL="${EDITOR}"

# Prefer GNU utilities from Homebrew on macOS.
if [[ "$(uname)" == "Darwin" ]]; then
  BREW_BIN="/usr/local/bin/brew"
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    BREW_BIN="/opt/homebrew/bin/brew"
  fi

  if [[ -x "${BREW_BIN}" ]]; then
    export BREW_PREFIX="$("${BREW_BIN}" --prefix)"

    for bindir in "${BREW_PREFIX}/opt/"*/libexec/gnubin; do
      [[ -d "${bindir}" ]] && path_prepend "${bindir}"
    done
    for bindir in "${BREW_PREFIX}/opt/"*/bin; do
      [[ -d "${bindir}" ]] && path_prepend "${bindir}"
    done
    for mandir in "${BREW_PREFIX}/opt/"*/libexec/gnuman; do
      [[ -d "${mandir}" ]] && export MANPATH="${mandir}${MANPATH:+:${MANPATH}}"
    done
    for mandir in "${BREW_PREFIX}/opt/"*/share/man/man1; do
      [[ -d "${mandir}" ]] && export MANPATH="${mandir}${MANPATH:+:${MANPATH}}"
    done
  fi
fi

# dircolors (Linux) / gdircolors (macOS via coreutils)
if command -v dircolors >/dev/null 2>&1; then
  eval $(dircolors ~/.dotfiles/LS_COLORS/LS_COLORS)
elif command -v gdircolors >/dev/null 2>&1; then
  eval $(gdircolors ~/.dotfiles/LS_COLORS/LS_COLORS)
fi

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
if [[ "$(uname)" != "Darwin" ]]; then
  export CHROOT="${HOME}/work/arch/chroot"
fi

# FIX for missing VAAPI driver
# export LIBVA_DRIVER_NAME=vdpau

# ansible python argcomplet
if command -v register-python-argcomplete >/dev/null 2>&1 ; then
  eval $(register-python-argcomplete ansible)
  eval $(register-python-argcomplete ansible-config)
  eval $(register-python-argcomplete ansible-console)
  eval $(register-python-argcomplete ansible-doc)
  eval $(register-python-argcomplete ansible-galaxy)
  eval $(register-python-argcomplete ansible-inventory)
  eval $(register-python-argcomplete ansible-playbook)
  eval $(register-python-argcomplete ansible-pull)
  eval $(register-python-argcomplete ansible-vault)
fi
