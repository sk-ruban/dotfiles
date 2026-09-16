# dotfiles

My personal dotfiles repository.

![Terminal](assets/terminal.png)

## Installation

```bash
git clone "https://github.com/sk-ruban/dotfiles"
cd dotfiles
./install.sh
```

Installs Homebrew, everything in `homebrew/Brewfile`, Python via uv and Oh My Zsh, symlinks each config to where its tool expects it, then installs Claude Code and cship. Safe to re-run — existing files are backed up to `<file>.backup` before being replaced.

## Layout

```
zsh/         zshrc
tmux/        tmux.conf          (kept for reference, not installed)
starship/    starship.toml
homebrew/    Brewfile
nvim/        init.lua, lua/plugins/*   (kept for reference, not installed)
helix/       config.toml
ghostty/     config
zed/         settings.json, themes/
wezterm/     wezterm.lua        (kept for reference, using ghostty)
claude/      CLAUDE.md, commands/, cship*.toml
codex/       AGENTS.md
mac/         system preference scripts, run manually
```

## Manual steps

`install.sh` doesn't do these:

- **Statusline** — `~/.claude/settings.json` isn't tracked. `install.sh` prints the `statusLine` block to paste if it isn't already configured.
- **System preferences** — the scripts in `mac/` use `defaults write` to change Dock, Finder and keyboard settings. Run them individually.

## Requirements

macOS.
