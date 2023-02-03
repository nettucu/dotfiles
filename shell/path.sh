path_prepend "~/bin"
path_prepend /opt/android-sdk-linux/tools
path_prepend /opt/android-sdk-linux/platform-tools
path_prepend "~/.dotnet/tools"

for d in $( \find /opt/scripts -type f -executable ! \( -path '**/.git/*' -o -path '**/conf/*' -o -path '**/cron*' -o -path '**/bcc/*' \) -printf '%h\n' | uniq ); do
    path_prepend "${d}"
done
export PATH

source /opt/google-cloud-sdk/path.zsh.inc
