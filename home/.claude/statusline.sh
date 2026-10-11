#!/usr/bin/env bash
# Claude Code status line.
# Fills come from the catppuccin mocha surface ramp, not its accents, so the bar
# stays quiet beside the prompt; path/git/model reuse the prompt's own hues.

input=$(cat)

# --- Headroom ---
# Reports usage to the relay and returns immediately: the network happens in a
# detached child, so this cannot slow the prompt down. The key is a write-only
# push key, read from a file so it never appears in `ps`.
printf '%s' "$input" | "$HOME/.local/bin/headroom" push \
  --relay https://headroom.orlyk.party \
  --secret-file "$HOME/.config/headroom/push-key" >/dev/null 2>&1
# --- end Headroom ---

SURFACE0="49;50;68"
SURFACE1="69;71;90"
OVERLAY1="127;132;156"
TEXT="205;214;244"
PINK="245;194;231"
LAVENDER="180;190;254"
BLUE="137;180;250"
GREEN="166;227;161"
YELLOW="249;226;175"
PEACH="250;179;135"
RED="243;139;168"

# Literal Private-Use-Area glyphs. A pipe or editor that is not UTF-8 clean
# empties them without error, and the bar loses its separators and icons.
CAP_L=$''
CAP_R=$''
SEP=$''
FOLDER=$''
BRANCH=$''
DIRTY=$'●'
MODEL=$'\U000f06a9'
EFFORT=$''
CTX=$'\U000f035b'
WINDOW=$''
RESET=$''

# Foreground only: a reset here would drop the segment's fill too.
fg() { printf '\033[38;2;%sm%s' "$1" "$2"; }

heat() {
  if   [ "$1" -ge 85 ]; then printf '%s' "$RED"
  elif [ "$1" -ge 70 ]; then printf '%s' "$PEACH"
  elif [ "$1" -ge 50 ]; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"
  fi
}

declare -a SEG_TEXT SEG_BG
add() { SEG_TEXT+=("$1"); SEG_BG+=("$2"); }

IFS=$'\t' read -r cwd model effort ctx_pct fh_pct fh_reset < <(jq -r '
  [ (.workspace.current_dir // .cwd // ""),
    (.model.display_name // .model.id // "" | split(" (")[0]),
    (.effort.level // ""),
    (.context_window.used_percentage        // -1 | floor),
    (.rate_limits.five_hour.used_percentage // -1 | floor),
    (.rate_limits.five_hour.resets_at       // 0  | floor) ] | @tsv' <<<"$input")

[ -z "$cwd" ] && cwd="$PWD"
if [ "$cwd" = "$HOME" ]; then here="~"; else here=$(basename "$cwd"); fi
add " $(fg "$OVERLAY1" "$FOLDER ")$(fg "$PINK" "$here") " "$SURFACE0"

if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  [ -z "$branch" ] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  mark=""
  [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null)" ] && mark="$(fg "$PEACH" " $DIRTY")"
  add " $(fg "$OVERLAY1" "$BRANCH ")$(fg "$LAVENDER" "$branch")$mark " "$SURFACE1"
fi

if [ -n "$model" ]; then
  seg=" $(fg "$OVERLAY1" "$MODEL ")$(fg "$BLUE" "$model")"
  [ -n "$effort" ] && seg+="$(fg "$OVERLAY1" "  $EFFORT ")$(fg "$TEXT" "$effort")"
  add "$seg " "$SURFACE0"
fi

if [ "${ctx_pct:--1}" -ge 0 ]; then
  add " $(fg "$OVERLAY1" "$CTX ")$(fg "$(heat "$ctx_pct")" "${ctx_pct}%") " "$SURFACE1"
fi

if [ "${fh_pct:--1}" -ge 0 ]; then
  cells=8
  filled=$(( (fh_pct * cells + 50) / 100 ))
  [ "$filled" -gt "$cells" ] && filled=$cells
  bar=""
  for ((i = 0; i < cells; i++)); do
    if [ "$i" -lt "$filled" ]; then bar+=$'█'; else bar+=$'░'; fi
  done
  add " $(fg "$OVERLAY1" "$WINDOW ")$(fg "$(heat "$fh_pct")" "$bar")$(fg "$TEXT" " ${fh_pct}%") " "$SURFACE0"

  rem=$(( fh_reset - $(date +%s) ))
  [ "$rem" -lt 0 ] && rem=0
  h=$(( rem / 3600 )); m=$(( (rem % 3600) / 60 ))
  if [ "$h" -gt 0 ]; then left="${h}h ${m}m"; else left="${m}m"; fi
  add " $(fg "$OVERLAY1" "$RESET ")$(fg "$LAVENDER" "$left") " "$SURFACE1"
fi

n=${#SEG_TEXT[@]}
[ "$n" -eq 0 ] && exit 0

out=$(fg "${SEG_BG[0]}" "$CAP_L")
for ((i = 0; i < n; i++)); do
  out+=$'\033[48;2;'"${SEG_BG[$i]}"'m'"${SEG_TEXT[$i]}"
  if [ "$i" -lt $(( n - 1 )) ]; then
    out+=$'\033[48;2;'"${SEG_BG[$((i + 1))]}"'m'"$(fg "${SEG_BG[$i]}" "$SEP")"
  fi
done
printf '%s\033[0m%s\033[0m' "$out" "$(fg "${SEG_BG[$((n - 1))]}" "$CAP_R")"
