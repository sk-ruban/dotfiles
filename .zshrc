# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝

export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	colored-man-pages
)

typeset -U path
path=(
    '/opt/homebrew/bin'
    "$HOME/.juliaup/bin"(N)
    "$HOME/.codeium/windsurf/bin"(N)
    $path
)
export PATH

export EDITOR="hx"
export VISUAL="hx"

if command -v eza > /dev/null 2>&1; then
    export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="eza --group-directories-first"
alias ll="eza -lh --git --group-directories-first"
alias lt="eza --tree --level=2 --git-ignore"

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
