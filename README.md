# dotfiles

This repository is now a `chezmoi` source directory.

## Bootstrap

From a fresh machine:

```bash
chezmoi init <repo-url>
chezmoi apply
```

From an existing local clone:

```bash
chezmoi init --source="$HOME/.dotfiles"
chezmoi apply
```

## Layout

- Shared shell helpers live under `~/.config/shell`
- Zsh plugin definitions live under `~/.config/zsh/plugins.txt`
- The active Kitty theme lives at `~/.config/kitty/current-theme.conf` — chezmoi seeds the default theme on first apply but never overwrites it after that, so `kitty +kitten themes` works freely
- A full copy of `kovidgoyal/kitty-themes` is cloned to `~/.config/kitty/.kitty-themes/` by chezmoi externals
- `LS_COLORS` is managed directly as `~/.config/dircolors/LS_COLORS`
- `antidote` is installed on first apply into `${XDG_DATA_HOME:-$HOME/.local/share}/antidote`
- `fnm` + Node.js LTS are installed on first apply on all platforms
  - Linux: fnm binary installed to `~/.local/bin` via the official curl installer
  - macOS: installed via Homebrew along with other packages (see `macos.brew.packages` in `.chezmoidata.yaml`)
  - Windows: installed via `winget` (see `windows.packages` in `.chezmoidata.yaml`)

## macOS

Edit `macos.brew.packages` in `.chezmoidata.yaml` to change the default Homebrew package set.

## Windows

Windows support is intentionally limited to package bootstrap and a small set of safe Explorer defaults.

- Packages are installed with `winget`
- Git is included so Git Bash is available by default
- No debloat, service removal, or destructive registry changes are applied

Edit `.chezmoidata.yaml` to change the default Windows package set.
