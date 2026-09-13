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

./bootstrap.sh   # install the toolchain
./install.sh     # link the dotfiles
```

`bootstrap.sh` installs Homebrew and everything in `Brewfile`, then the tools
that ship their own installers and self-update outside Homebrew — `uv`,
`atuin`, `rustup` — followed by the Python CLI apps and Node. Every step is
skipped if already present, so it is safe to re-run.

`install.sh` only creates symlinks.

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

`Brewfile` and `bootstrap.sh` install the toolchain; `install.sh` links the
dotfiles.

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

`bootstrap.sh` installs everything. Every integration in `.zshrc` is also
guarded, so the shell works before any of it exists and lights up
progressively as tools appear.

Three dependencies install themselves rather than coming from `Brewfile`:

- [zi](https://github.com/z-shell/zi) — clones itself on first shell start
- [atuin](https://atuin.sh) — `bootstrap.sh`; run `atuin login` after
- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) — cloned by `install.sh`

## Neovim

Stock [LazyVim](https://lazyvim.org) starter, intentionally unmodified. The
enabled extras are in `nvim/lazyvim.json`.

`lazy-lock.json` is not tracked, so plugins float: a fresh clone installs
whatever is current, and `:Lazy update` takes the latest. Pin a working set on
one machine with `:Lazy restore` against a lockfile copied by hand.
