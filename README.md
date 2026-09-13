# dotfiles

macOS configuration. The repository root **is** `$XDG_CONFIG_HOME` (`~/.config`),
so files under `nvim/`, `ghostty/` and `workmux/` are already where
they need to be. Files that belong in `$HOME` live in `home/` and are symlinked
by `install.sh`.

## Install

```sh
mkdir -p ~/.config && cd ~/.config
git init -b main
git remote add origin git@github.com:andriykohut/dotfiles.git
git fetch origin
git checkout -f main
./install.sh
```

`~/.config` usually already exists and contains files, which is why this is an
`init`-and-`fetch` rather than a `git clone`.

`install.sh` backs up anything it would overwrite into
`~/.dotfiles-backup/<timestamp>/`, and is safe to re-run.

## Layout

| Path | Goes to |
| --- | --- |
| `home/.zshenv`, `.zprofile`, `.zshrc` | `~` |
| `home/.gitconfig`, `.gitignore` | `~` |
| `home/.git-hooks/` | `~/.git-hooks` |
| `home/.tmux.conf.local` | `~` |
| `nvim/`, `ghostty/`, `workmux/` | already in place |

Everything else in `~/.config` is ignored by default — see `.gitignore`. The
allowlist is deliberate: installed tools write credentials into this directory,
so opting files in is the only safe default.

## Machine-specific settings

Two files are intentionally **not** tracked:

- `~/.gitconfig.local` — name, email, signing key, `maintenance.repo` entries.
  `install.sh` seeds it from `home/.gitconfig.local.example`.
- `~/.zshrc.local` — anything machine-specific; sourced at the end of `.zshrc`
  if present.

## Dependencies

Every integration in `.zshrc` is guarded, so the shell works before any of
these exist and lights up progressively as they are installed.

```sh
brew install zsh neovim tmux fzf fd ripgrep eza bat zoxide git-delta oh-my-posh gnupg pinentry-mac
```

- [zi](https://github.com/z-shell/zi) — installs itself on first shell start
- [atuin](https://atuin.sh) — shell history, standalone installer
- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) — cloned by `install.sh`

## Neovim

Stock [LazyVim](https://lazyvim.org) starter, intentionally unmodified. Plugin
versions are pinned in `nvim/lazy-lock.json`.
