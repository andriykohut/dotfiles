export LC_ALL="en_US.UTF-8"
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi
export N_PREFIX=$HOME/.n
export PATH=/usr/local/bin:$N_PREFIX/bin:$PATH

# Every integration below is guarded, so a fresh clone gives a working shell
# before any of the tools it references are installed.

# - zi ----------
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
if [[ -f $HOME/.zi/bin/zi.zsh ]]; then
  source "$HOME/.zi/bin/zi.zsh"
  autoload -Uz _zi
  (( ${+_comps} )) && _comps[zi]=_zi
  # examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes

  zi light zsh-users/zsh-completions
  zi light zsh-users/zsh-autosuggestions
  zi snippet OMZL::git.zsh
  zi snippet OMZP::git

  zicompinit # <- https://wiki.zshell.dev/docs/guides/commands
fi

# - gcloud ----------
if command -v brew > /dev/null 2>&1; then
  gcloud_sdk="$(brew --prefix)/share/google-cloud-sdk"
  [[ -f $gcloud_sdk/path.zsh.inc ]] && source "$gcloud_sdk/path.zsh.inc"
  [[ -f $gcloud_sdk/completion.zsh.inc ]] && source "$gcloud_sdk/completion.zsh.inc"
  unset gcloud_sdk
fi

# - zoxide ----------
if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh --no-cmd)"
  alias z=__zoxide_z
  alias zz=__zoxide_zi
fi

# - fzf ----------
if command -v fd > /dev/null 2>&1; then
  # fd honours .gitignore, so target/ and node_modules stay out of the picker.
  export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

  # Used by the ** completion trigger, which ignores FZF_CTRL_T_COMMAND.
  _fzf_compgen_path() { fd --hidden --follow --exclude .git . "$1" }
  _fzf_compgen_dir()  { fd --type d --hidden --follow --exclude .git . "$1" }
fi
# Must stay above atuin — both bind Ctrl-R, and the later init wins.
command -v fzf > /dev/null 2>&1 && source <(fzf --zsh)

# - atuin ----------
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"
command -v atuin > /dev/null 2>&1 && eval "$(atuin init zsh --disable-up-arrow)"

# - bat ----------
if command -v bat > /dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  # Without -c, groff emits ANSI sequences bat renders as literal escapes.
  export MANROFFOPT="-c"
fi

# - aliases ----------
if command -v eza > /dev/null 2>&1; then
  alias ls='eza'
  alias l='eza -lbF --git'
  alias ll='eza -lbGF --git'
fi

command -v oh-my-posh > /dev/null 2>&1 && \
  eval "$(oh-my-posh init zsh --config "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/oh-my-posh/themes/catppuccin_mocha.omp.json")"

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
if command -v uv > /dev/null 2>&1; then
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi

[[ -d "$HOME/.platformio/penv/bin" ]] && export PATH=$PATH:$HOME/.platformio/penv/bin

# - Android SDK ----------
if [[ -d "$HOME/Library/Android/sdk" ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export ANDROID_SDK_ROOT="$ANDROID_HOME"
  export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
fi

# Claude Code drops to 256 colours whenever $TMUX is set, flattening the
# statusline palette. TERM, COLORTERM and FORCE_COLOR do not override it.
claude() { env -u TMUX -u TMUX_PANE command claude "$@"; }

# Machine-specific settings that should not be shared live here.
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# - zsh-patina (syntax highlighting) ----------
# Must stay at the very end of .zshrc, after everything else.
if command -v zi > /dev/null 2>&1 || [[ -f $HOME/.zi/bin/zi.zsh ]]; then
  zi ice as"program" from"gh-r" pick"zsh-patina-*/zsh-patina" atload'eval "$(zsh-patina activate)" && eval "$(zsh-patina completion)"'
  zi light michel-kraemer/zsh-patina
fi
