#!/bin/sh
# Install the full toolchain: Homebrew packages from the Brewfile, then the
# tools that ship their own installers and self-update outside Homebrew.
# Idempotent -- every step is skipped if the tool is already present.
#
# Run install.sh afterwards to link the dotfiles.
set -eu

DOTFILES=$(cd "$(dirname "$0")" && pwd)

have() { command -v "$1" > /dev/null 2>&1; }

step() { printf '\n==> %s\n' "$1"; }

step "Homebrew"
if have brew; then
    echo "    already installed"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

step "Homebrew packages"
brew bundle --file="$DOTFILES/Brewfile"
if [ -f "$DOTFILES/Brewfile.local" ]; then
    step "Homebrew packages (this machine only)"
    brew bundle --file="$DOTFILES/Brewfile.local"
fi

step "uv (owns Python interpreters and Python CLI apps)"
if have uv; then
    echo "    already installed"
else
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi
# The installer drops uv here before any shell restart makes it visible.
PATH="$HOME/.local/bin:$PATH"
export PATH

step "atuin (shell history)"
if have atuin; then
    echo "    already installed"
else
    curl --proto '=https' --tlsv1.2 -LsSf \
        https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh | sh
    echo "    run 'atuin login' and 'atuin sync' to pull history"
fi

step "rustup (Rust toolchain)"
if have cargo; then
    echo "    already installed"
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

step "Python runtime and CLI apps"
uv python install 3.13
uv tool install --quiet ruff
uv tool install --quiet mypy
uv tool install --quiet pyright
uv tool install --quiet mpremote
uv tool install --quiet jellyfin-mpv-shim
uv tool list

step "Node"
# n reads N_PREFIX; .zshrc exports it, but this script may run before that.
N_PREFIX="$HOME/.n"
export N_PREFIX
PATH="$N_PREFIX/bin:$PATH"
export PATH
if [ -x "$N_PREFIX/bin/node" ]; then
    echo "    already installed: $("$N_PREFIX/bin/node" --version)"
else
    n lts
fi

printf '\n==> Done.\n'
printf 'Next: %s/install.sh to link the dotfiles, then open a new shell.\n' "$DOTFILES"
