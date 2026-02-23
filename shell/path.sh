path_prepend "${HOME}/bin"
path_prepend "${HOME}/.local/bin"
[[ -d /opt/android-sdk-linux ]] && path_prepend /opt/android-sdk-linux
[[ -d /opt/android-sdk-linux/tools ]] && path_prepend /opt/android-sdk-linux/tools
[[ -d /opt/android-sdk-linux/platform-tools ]] && path_prepend /opt/android-sdk-linux/platform-tools
path_prepend "${HOME}/.dotnet/tools"

if [[ -d /opt/scripts ]]; then
  if command -v gfind >/dev/null 2>&1; then
    find_cmd="gfind"
  else
    find_cmd="find"
  fi

  while IFS= read -r d; do
    path_prepend "${d}"
  done < <(
    "${find_cmd}" /opt/scripts -type f -perm -u+x \
      ! \( -path '*/.git/*' -o -path '*/conf/*' -o -path '*/cron*' -o -path '*/bcc/*' \) \
      -exec dirname {} \; | sort -u
  )
fi
export PATH

if [[ -f /opt/google-cloud-cli/path.zsh.inc ]]; then
  source /opt/google-cloud-cli/path.zsh.inc
fi
