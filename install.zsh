#!/usr/bin/zsh

# very simple install for now

DOTFILES_HOME=${0:a:h}

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}

ln -sf ${DOTFILES_HOME}/zshrc ~/.zshrc

# nvim customizations
mkdir -p ${XDG_DATA_HOME}/nvim/site/autoload
ln -sf ${DOTFILES_HOME}/nvim/vim-plug/plug.vim ${XDG_DATA_HOME}/nvim/site/autoload

[[ ! -d ${XDG_CONFIG_HOME}/nvim ]] && mkdir -p ${XDG_CONFIG_HOME}/nvim
ln -sf ${DOTFILES_HOME}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/


