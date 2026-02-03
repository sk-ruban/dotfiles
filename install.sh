#!/bin/bash

# Dotfiles Installation Script
# Run with: ./install.sh

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

print_status "Starting dotfiles installation from: $DOTFILES_DIR"

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only"
    exit 1
fi

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for M1/M2 Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# Install essential packages
print_status "Installing packages via Homebrew..."
brew install \
    neovim \
    tmux \
    starship \
    eza \
    zoxide \
    git \
    curl \
    wget

# Install WezTerm
if ! brew list --cask wezterm &> /dev/null; then
    print_status "Installing WezTerm..."
    brew install --cask wezterm
    print_success "WezTerm installed"
else
    print_success "WezTerm already installed"
fi

# Install JetBrainsMono Nerd Font
if ! brew list --cask font-jetbrains-mono-nerd-font &> /dev/null; then
    print_status "Installing JetBrainsMono Nerd Font..."
    if brew install --cask font-jetbrains-mono-nerd-font; then
        print_success "JetBrainsMono Nerd Font installed"
    else
        print_warning "Font installation failed, you can install it manually later"
        print_status "Alternative: Download from https://github.com/ryanoasis/nerd-fonts"
    fi
else
    print_success "JetBrainsMono Nerd Font already installed"
fi

# Install Claude Code
if ! command -v claude &> /dev/null; then
    print_status "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
    print_success "Claude Code installed"
else
    print_success "Claude Code already installed"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_success "Oh My Zsh already installed"
fi

# Install Oh My Zsh plugins
print_status "Installing Oh My Zsh plugins..."

# zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

print_success "Oh My Zsh plugins installed"

# Create symlinks for config files
print_status "Creating symlinks for config files..."

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        print_warning "Backing up existing $target to $target.backup"
        mv "$target" "$target.backup"
    fi

    ln -sf "$source" "$target"
    print_success "Linked $source -> $target"
}

# Symlink dotfiles
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.gitignore" "$HOME/.gitignore"

# Symlink config directories
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/.config/wezterm" "$HOME/.config/wezterm"
create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.claude"
create_symlink "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

print_status "Setting up Zed configuration..."
mkdir -p "$HOME/.config/zed/themes"
create_symlink "$DOTFILES_DIR/.config/zed/settings.json" "$HOME/.config/zed/settings.json"
create_symlink "$DOTFILES_DIR/.config/zed/themes/0x96f-theme.json" "$HOME/.config/zed/themes/0x96f-theme.json"

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    print_status "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    print_success "tmux plugin manager installed"
    print_warning "Run 'tmux' then press 'Ctrl+x + I' to install tmux plugins"
else
    print_success "tmux plugin manager already installed"
fi

print_success "Dotfiles installation complete!"
print_status "Please restart your terminal or run 'source ~/.zshrc' to load the new configuration"
print_status "For tmux plugins, start tmux and press 'Ctrl+x + I'"
