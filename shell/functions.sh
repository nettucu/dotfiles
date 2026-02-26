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
