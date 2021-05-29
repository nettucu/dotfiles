# Check for an interactive session
[ -z "$PS1" ] && return

source ~/.dotfiles/shell/functions.sh

source ~/.dotfiles/shell/env.sh

PS1='\[\033[1;33m\]\u@\h\[\033[1;34m\]:\[\033[1;33m\]\w\[\033[0m\]\[\033[1;33m\]\$\[\033[0m\] '

export VBOX_USB=usbfs

# don't put duplicate lines in the history. See bash(1) for more options
export HISTFILESIZE=300000    # save 300000 commands
export HISTCONTROL=ignoredups    # no duplicate lines in the history.
export HISTSIZE=100000
export HISTIGNORE="&:[bf]g:exit"
export HISTTIMEFORMAT='+%Y-%m-%d %H:%M:%S'


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histappend
# save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# correct some misspelling
shopt -s cdspell

# reread history file all the time
export PROMPT_COMMAND='history -a'

#aliases
alias histupd="history -n"

[[ -f /opt/scripts/vbox_vms/bin/vm_functions.sh ]] && source /opt/scripts/vbox_vms/bin/vm_functions.sh

source ~/.dotfiles/shell/aliases.sh

source ~/.dotfiles/shell/path.sh

_dotnet_bash_complete()
{
  local word=${COMP_WORDS[COMP_CWORD]}

  local completions
  completions="$(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)"
  if [ $? -ne 0 ]; then
    completions=""
  fi

  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -f -F _dotnet_bash_complete dotnet

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
