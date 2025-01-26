path_prepend "${HOME}/bin"
path_prepend /opt/android-sdk-linux/tools
path_prepend /opt/android-sdk-linux/platform-tools
path_prepend "${HOME}/.dotnet/tools"

for d in $(\find /opt/scripts -type f -executable ! \( -path '**/.git/*' -o -path '**/conf/*' -o -path '**/cron*' -o -path '**/bcc/*' \) -printf '%h\n' | uniq); do
  path_prepend "${d}"
done
export PATH

if [[ -f /opt/google-cloud-cli/path.zsh.inc ]]; then
  source /opt/google-cloud-cli/path.zsh.inc
fi
