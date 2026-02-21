#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════╗
# ║  sessionizer.sh — FZF-powered tmux project switcher     ║
# ║  Bind to: prefix + f                                     ║
# ║                                                          ║
# ║  Searches common project dirs, lets you fuzzy-pick,      ║
# ║  then creates or switches to the tmux session.           ║
# ╚══════════════════════════════════════════════════════════╝

# ── Configure your project directories here ─────────────────
PROJECT_DIRS=(
  "$HOME/code"
  "$HOME/projects"
  "$HOME/work"
  "$HOME/src"
  "$HOME/dev"
  "$HOME/repos"
  "$HOME/go/src"
  "$HOME/.config"
)

# Max depth to search within each directory
DEPTH=3

# ── Build find commands for existing dirs only ───────────────
find_args=()
for dir in "${PROJECT_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    find_args+=("$dir")
  fi
done

# ── Find directories (git repos first, then any dir) ─────────
if [ ${#find_args[@]} -eq 0 ]; then
  # Fallback to home
  find_args=("$HOME")
fi

selected=$(
  {
    # Git repos get priority
    fd --type d --hidden --max-depth "$DEPTH" '\.git$' "${find_args[@]}" 2>/dev/null \
      | xargs -I{} dirname {} \
      | sort -u

    # Then all top-level dirs
    fd --type d --max-depth 1 . "${find_args[@]}" 2>/dev/null \
      | sort -u
  } \
  | sort -u \
  | sed "s|$HOME|~|g" \
  | fzf \
      --reverse \
      --prompt="  Session: " \
      --header="Select or type a project path" \
      --preview="ls -la \$(echo {} | sed \"s|~|$HOME|\")" \
      --preview-window="right:40%:wrap" \
      --bind="ctrl-n:print-query"  # create session with typed name
)

[ -z "$selected" ] && exit 0

# Expand ~ back
selected="${selected/#\~/$HOME}"

# Derive a clean session name from the path
session_name=$(basename "$selected" | tr ' .:' '_')

# ── Switch or create ─────────────────────────────────────────
if ! tmux has-session -t "$session_name" 2>/dev/null; then
  tmux new-session -ds "$session_name" -c "$selected"

  # Pre-create a useful window layout for the project
  # Window 1: editor (nvim)
  tmux rename-window -t "$session_name:1" "editor"
  tmux send-keys -t "$session_name:1" "nvim ." Enter

  # Window 2: shell
  tmux new-window -t "$session_name" -c "$selected" -n "shell"

  # Window 3: git (lazygit)
  tmux new-window -t "$session_name" -c "$selected" -n "git"
  tmux send-keys -t "$session_name:3" "lazygit" Enter

  # Focus editor window
  tmux select-window -t "$session_name:1"
fi

tmux switch-client -t "$session_name"
