#!/bin/sh
# Link the tracked dotfiles into $HOME and fetch the upstream projects they
# depend on. Safe to re-run; existing files are backed up, never overwritten.
set -eu

DOTFILES=$(cd "$(dirname "$0")" && pwd)
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
    src=$DOTFILES/home/$1
    dst=$HOME/$1

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        printf '  ok       %s\n' "$1"
        return
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP/$(dirname "$1")"
        mv "$dst" "$BACKUP/$1"
        printf '  backed up %s -> %s\n' "$1" "$BACKUP/$1"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    printf '  linked   %s\n' "$1"
}

echo "Linking dotfiles from $DOTFILES"
link .zshenv
link .zprofile
link .zshrc
link .gitconfig
link .gitignore
link .git-hooks
link .tmux.conf.local

if [ ! -f "$HOME/.gitconfig.local" ]; then
    cp "$DOTFILES/home/.gitconfig.local.example" "$HOME/.gitconfig.local"
    echo
    echo "Created ~/.gitconfig.local from the template — set your name, email"
    echo "and signing key there. It is not tracked."
fi

if [ ! -d "$HOME/.tmux" ]; then
    echo
    echo "Cloning gpakosz/.tmux"
    git clone --depth=1 https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
fi
# Upstream's own config; ours is .tmux.conf.local, linked above.
ln -sf "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"

echo
echo "Done. Open a new shell."
echo "Neovim, ghostty, htop and workmux configs are already in place under"
echo "this directory, which is \$XDG_CONFIG_HOME."
