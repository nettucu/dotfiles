path_prepend "${HOME}/bin"
path_prepend "{$HOME}/.local/bin"
[[ -d /opt/android-sdk-linux ]] && path_prepend /opt/android-sdk-linux
[[ -d /opt/android-sdk-linux/tools ]] && path_prepend /opt/android-sdk-linux/tools
[[ -d /opt/android-sdk-linux/platform-tools ]] && path_prepend /opt/android-sdk-linux/platform-tools
path_prepend "${HOME}/.dotnet/tools"

if [[ -d /opt/scripts ]]; then
  for d in $(\find /opt/scripts -type f -executable ! \( -path '**/.git/*' -o -path '**/conf/*' -o -path '**/cron*' -o -path '**/bcc/*' \) -printf '%h\n' | uniq); do
    path_prepend "${d}"
  done
fi
export PATH

if [[ -f /opt/google-cloud-cli/path.zsh.inc ]]; then
  source /opt/google-cloud-cli/path.zsh.inc
fi
