export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git 
	zsh-syntax-highlighting
	colored-man-pages
    zsh-autosuggestions
)

path=(
    '/opt/homebrew/bin'
    '/Users/ruban/.juliaup/bin'
    $path
)
export PATH

export FPATH="<path_to_eza>/completions/zsh:$FPATH"

alias vim="nvim"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="eza --icons=always"

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
