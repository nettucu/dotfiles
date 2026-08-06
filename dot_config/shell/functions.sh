# comon functions for both bash and zsh

if [[ -n "$ZSH_VERSION" ]]; then
    # In Zsh, the 'path' array is tied to 'PATH'.
    # 'typeset -U' ensures that the array only contains unique elements.
    typeset -U path
fi

path_remove() {
    if [[ -n "$ZSH_VERSION" ]]; then
        path=("${path[@]:#$1}")
    else
        PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
    fi
}

path_append() {
    if [[ -n "$ZSH_VERSION" ]]; then
        path+=("$1")
    else
        path_remove "$1"
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

path_prepend() {
    if [[ -n "$ZSH_VERSION" ]]; then
        path=("$1" "${path[@]}")
    else
        path_remove "$1"
        PATH="$1${PATH:+":$PATH"}"
    fi
}

rename-invoices() {
    local dry_run=0
    [[ "$1" == "-n" || "$1" == "--dry-run" ]] && dry_run=1

    bash -c '
      dry_run=$1; shift
      count=0
      for f in *.pdf; do
        [[ "$f" =~ ^[0-9]{4}\.[0-9]{2}\.[0-9]{2}- ]] && continue
        if [[ "$f" =~ __([0-9]{2})-([0-9]{2})-([0-9]{4})__ ]]; then
          new="${BASH_REMATCH[3]}.${BASH_REMATCH[2]}.${BASH_REMATCH[1]}-${f}"
        elif [[ "$f" =~ __([0-9]{2})_([0-9]{2})_([0-9]{4})\.pdf$ ]]; then
          new="${BASH_REMATCH[3]}.${BASH_REMATCH[2]}.${BASH_REMATCH[1]}-${f}"
        else
          continue
        fi
        if [[ "$dry_run" == "1" ]]; then
          echo "[dry-run] $f  ->  $new"
        else
          mv -- "$f" "$new" && ((count++))
        fi
      done
      [[ "$dry_run" == "0" ]] && echo "Renamed $count files."
    ' _ "$dry_run"
  }

# ---------------------------------------------------------------------------
# Work proxy (Oracle)
# ---------------------------------------------------------------------------
_WORK_PROXY="http://www-proxy-wdc.oraclecorp.com:80"
_WORK_DOMAIN="oracle.com"
_WORK_NO_PROXY="localhost,127.0.0.1,::1,*.oracle.com,*.oraclecloud.com"

proxy_on() {
    export HTTP_PROXY="$_WORK_PROXY"
    export HTTPS_PROXY="$_WORK_PROXY"
    export http_proxy="$_WORK_PROXY"
    export https_proxy="$_WORK_PROXY"
    export NO_PROXY="$_WORK_NO_PROXY"
    export no_proxy="$_WORK_NO_PROXY"
}

proxy_off() {
    unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy NO_PROXY no_proxy
}

# Returns 0 if on work network. Checks (fast first, network last):
#   1. DNS search domain contains oracle.com
#   2. Default route goes through a VPN tunnel interface
#   3. Proxy host is reachable (slow — only runs if 1 & 2 fail)
_proxy_detect() {
    local _os
    _os="$(uname)"

    # 1. DNS search domain (no network, fast)
    if [[ "$_os" == "Darwin" ]]; then
        scutil --dns 2>/dev/null | grep -q "search domain\[.*\] : .*${_WORK_DOMAIN}" && return 0
    else
        grep -qE "^search\s.*${_WORK_DOMAIN}" /etc/resolv.conf 2>/dev/null && return 0
    fi

    # 2. VPN tunnel interface on default route (no network, fast)
    if [[ "$_os" == "Darwin" ]]; then
        netstat -rn 2>/dev/null | awk '/^default/{print $NF}' | grep -q "^utun" && return 0
    else
        ip route show default 2>/dev/null | grep -qE "dev (tun|vpn)[0-9]" && return 0
    fi

    # 3. Proxy reachable (network — fallback only)
    nc -z -w2 www-proxy-wdc.oraclecorp.com 80 2>/dev/null && return 0

    return 1
}

# Auto-configure proxy on shell startup
if _proxy_detect; then
    proxy_on
fi
