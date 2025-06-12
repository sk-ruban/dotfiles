export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git 
	zsh-syntax-highlighting
	colored-man-pages
    zsh-autosuggestions
)

path=(
    '/opt/homebrew/bin'
    $path
)
export PATH

if command -v eza > /dev/null 2>&1; then
    export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

alias vim="nvim"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="eza --icons=always"

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
