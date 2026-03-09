#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

assert_exists() {
  local path="$1"
  if [[ ! -e "${repo_root}/${path}" ]]; then
    printf 'missing: %s\n' "${path}" >&2
    exit 1
  fi
}

assert_missing() {
  local path="$1"
  if [[ -e "${repo_root}/${path}" ]]; then
    printf 'unexpected: %s\n' "${path}" >&2
    exit 1
  fi
}

assert_exists ".chezmoi.toml.tmpl"
assert_exists ".chezmoidata.yaml"
assert_exists ".chezmoiignore.tmpl"
assert_exists "dot_bash_profile"
assert_exists "dot_bashrc"
assert_exists "dot_config/bat/config"
assert_exists "dot_config/dircolors/LS_COLORS"
assert_exists "dot_config/kitty/create_current-theme.conf"
assert_exists "dot_config/kitty/kitty.conf"
assert_exists "dot_config/kitty/.chezmoiexternal.toml"
assert_exists "dot_config/lsd/config.yaml"
assert_exists "dot_config/nvim/init.lua"
assert_exists "dot_config/starship.toml"
assert_exists "dot_config/zsh/plugins.txt"
assert_exists "dot_gitconfig"
assert_exists "dot_gitignore_global"
assert_exists "dot_inputrc"
assert_exists "dot_zshrc"
assert_exists "run_once_before_10-install-antidote.sh.tmpl"
assert_exists "run_once_before_20-windows-packages.ps1.tmpl"
assert_exists "run_once_before_30-windows-defaults.ps1.tmpl"
assert_exists "run_once_before_40-linux-packages.sh.tmpl"
assert_exists "run_once_before_45-server-packages.sh.tmpl"
assert_exists "run_once_before_50-macos-packages.sh.tmpl"
assert_exists "run_once_before_60-install-node-lts.sh.tmpl"
assert_exists "run_once_before_70-install-npm-globals.sh.tmpl"
assert_missing "install"
assert_missing "install.conf.yaml"
assert_missing ".gitmodules"
