#!/bin/bash

# Read JSON input
input=$(cat)

# Extract data from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model_id=$(echo "$input" | jq -r '.model.id')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
current_input=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
session_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# Current directory (shortened if in home)
dir=${cwd/#$HOME/\~}
if [[ $(echo "$dir" | tr -cd '/' | wc -c) -gt 2 ]]; then
  dir="...$(echo "$dir" | rev | cut -d'/' -f1,2 | rev)"
fi

# Git status
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" -c gc.autodetach=false branch --show-current 2>/dev/null || echo "HEAD")
  git_status=""
  if ! git -C "$cwd" -c gc.autodetach=false diff-index --quiet HEAD -- 2>/dev/null; then
    git_status="*"
  fi
  if [[ -n $(git -C "$cwd" -c gc.autodetach=false ls-files --others --exclude-standard 2>/dev/null) ]]; then
    git_status="${git_status}+"
  fi
  git_info=$(printf "\033[2m on \033[0m\033[36m%s\033[0m%s" "$branch" "$git_status")
fi

# Virtual environment
venv_info=""
if [[ -n "$VIRTUAL_ENV" ]]; then
  venv_name=$(basename "$VIRTUAL_ENV")
  venv_info=$(printf " \033[2m(\033[0m\033[33m%s\033[0m\033[2m)\033[0m" "$venv_name")
fi

# Context usage (used/max tokens + percentage)
context_info=""
if [[ -n "$used_pct" ]] && [[ "$context_size" != "0" ]]; then
  used_tokens=$((current_input + cache_create + cache_read))
  used_k=$((used_tokens / 1000))
  max_k=$((context_size / 1000))
  context_info=$(printf " \033[2m[\033[0m\033[35m%sk/%sk %s%%\033[0m\033[2m]\033[0m" "$used_k" "$max_k" "$used_pct")
fi

# Session cost (from actual API cost data)
cost_info=""
if [[ -n "$session_cost" ]] && [[ "$session_cost" != "0" ]]; then
  cost_formatted=$(printf "%.2f" "$session_cost")
  total_tokens=$((total_input + total_output))
  if [[ $total_tokens -ge 1000000 ]]; then
    total_fmt="$(echo "scale=1; $total_tokens / 1000000" | bc)M"
  else
    total_fmt="$((total_tokens / 1000))k"
  fi
  cost_info=$(printf " \033[2m[\033[0m\033[32m\$%s \033[2m/\033[0m \033[32m%s tokens\033[0m\033[2m]\033[0m" "$cost_formatted" "$total_fmt")
fi

# Build the status line
printf "\033[2m%s@%s\033[0m \033[34m%s\033[0m%s%s%s%s" \
  "$(whoami)" \
  "$(hostname -s)" \
  "$dir" \
  "$git_info" \
  "$venv_info" \
  "$context_info" \
  "$cost_info"
