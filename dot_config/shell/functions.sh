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
