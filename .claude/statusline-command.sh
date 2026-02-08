#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model_name=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Catppuccin Mocha colors (using ANSI 256 color codes, dimmed)
surface0="\033[38;5;237m"
text="\033[38;5;189m"
peach="\033[38;5;216m"
green="\033[38;5;150m"
teal="\033[38;5;152m"
purple="\033[38;5;183m"
mantle="\033[38;5;234m"
red="\033[38;5;210m"
reset="\033[0m"

# Get OS symbol (macOS)
os_symbol=""

# Get username
username=$(whoami)

# Process directory path
dir_path="$current_dir"

# Apply Starship substitutions
dir_path="${dir_path/\/Users\/$username\/Documents/󰈙 }"
dir_path="${dir_path/\/Users\/$username\/Downloads/ }"
dir_path="${dir_path/\/Users\/$username\/Music/󰝚 }"
dir_path="${dir_path/\/Users\/$username\/Pictures/ }"
dir_path="${dir_path/\/Users\/$username\/Developer/󰲋 }"

# Replace home directory with ~
dir_path="${dir_path/#\/Users\/$username/~}"

# Truncate to last 3 segments if needed
IFS='/' read -ra PARTS <<< "$dir_path"
if [ ${#PARTS[@]} -gt 3 ]; then
  dir_path="…/${PARTS[-3]}/${PARTS[-2]}/${PARTS[-1]}"
fi

# Get git info (skip locks as per project guidelines)
git_info=""
if [ -d "$current_dir/.git" ] || git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -c core.fileMode=false -c core.fsmonitor=false -C "$current_dir" branch --show-current 2>/dev/null || echo "detached")
  if [ -n "$git_branch" ]; then
    status_output=$(git -c core.fsmonitor=false -C "$current_dir" status --porcelain 2>/dev/null)
    if [ -n "$status_output" ]; then
      total_files=$(echo "$status_output" | wc -l | xargs)
      line_stats=$(git -C "$current_dir" diff --numstat HEAD 2>/dev/null | awk '{a+=$1; r+=$2} END {print a+0, r+0}')
      added=$(echo "$line_stats" | cut -d' ' -f1)
      removed=$(echo "$line_stats" | cut -d' ' -f2)

      git_info=" ${git_branch} ${surface0}│${reset}"
      git_info+=" ${text}${total_files}f${reset}"
      [ "$added" -gt 0 ] 2>/dev/null && git_info+=" ${green}+${added}${reset}"
      [ "$removed" -gt 0 ] 2>/dev/null && git_info+=" ${red}−${removed}${reset}"
    else
      git_info=" ${git_branch} ${green}✓${reset}"
    fi
  fi
fi

# Get time
current_time=$(date +%R)

# Build the prompt segments (matching Starship format)
# Segment 1: OS + Username
printf "${text}${os_symbol} ${username} ${reset}"

# Segment 2: Directory (peach)
printf "${peach} ${dir_path} ${reset}"

# Segment 3: Git (if available, green)
if [ -n "$git_info" ]; then
  printf "${green}${git_info} ${reset}"
fi

# Segment 4: Model/Context info (teal)
if [ -n "$model_name" ]; then
  printf "${teal} ${model_name}"
  if [ -n "$used_pct" ]; then
    # Color code based on usage
    pct_int=${used_pct%.*}
    if [ "$pct_int" -gt 80 ] 2>/dev/null; then
      printf " ${red}${used_pct}%%${teal}"
    else
      printf " ${used_pct}%%"
    fi
  fi
  printf " ${reset}"
fi

# Segment 5: Time (purple)
printf "${purple}  ${current_time} ${reset}"

echo ""
