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

# Non-fatal: mas entries fail when not signed into the App Store, and set -e would abort the install
print_status "Installing packages from Brewfile..."
if brew bundle --file="$DOTFILES_DIR/Brewfile"; then
    print_success "Brewfile packages installed"
else
    print_warning "Some Brewfile entries failed. Check the output above."
    print_status "App Store apps need you signed into the App Store"
fi

# Install Python via uv
if command -v uv &> /dev/null; then
    print_status "Installing Python via uv..."
    uv python install --default
    print_success "Python installed"
else
    print_warning "uv not found, skipping Python install"
fi

# Install Claude Code
if ! command -v claude &> /dev/null; then
    print_status "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
    print_success "Claude Code installed"
else
    print_success "Claude Code already installed"
fi

# Install cship (Claude Code statusline renderer)
if [ ! -x "$HOME/.local/bin/cship" ]; then
    print_status "Installing cship..."
    case "$(uname -m)" in
        arm64)  CSHIP_TARGET="aarch64-apple-darwin" ;;
        x86_64) CSHIP_TARGET="x86_64-apple-darwin" ;;
        *)      print_error "Unsupported architecture: $(uname -m)"; exit 1 ;;
    esac
    mkdir -p "$HOME/.local/bin"
    curl -fsSL "https://github.com/stephenleo/cship/releases/latest/download/cship-${CSHIP_TARGET}" \
        -o "$HOME/.local/bin/cship"
    chmod +x "$HOME/.local/bin/cship"
    print_success "cship installed"
else
    print_success "cship already installed"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    print_success "Oh My Zsh installed"
else
    print_success "Oh My Zsh already installed"
fi

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

# Symlink config directories
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
create_symlink "$DOTFILES_DIR/zed" "$HOME/.config/zed"
create_symlink "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
create_symlink "$DOTFILES_DIR/helix" "$HOME/.config/helix"

mkdir -p "$HOME/.claude"
create_symlink "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
create_symlink "$DOTFILES_DIR/claude/commands" "$HOME/.claude/commands"
create_symlink "$DOTFILES_DIR/claude/cship.toml" "$HOME/.claude/cship.toml"
create_symlink "$DOTFILES_DIR/claude/cship-starship.toml" "$HOME/.claude/cship-starship.toml"

mkdir -p "$HOME/.codex"
create_symlink "$DOTFILES_DIR/codex/AGENTS.md" "$HOME/.codex/AGENTS.md"

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

if ! grep -q "cship" "$HOME/.claude/settings.json" 2>/dev/null; then
    print_warning "Statusline not wired up. Add to ~/.claude/settings.json (not tracked by this repo):"
    echo '  "statusLine": { "type": "command", "command": "STARSHIP_CONFIG=$HOME/.claude/cship-starship.toml $HOME/.local/bin/cship --config $HOME/.claude/cship.toml | sed -E '"'"'s/ \\([0-9]+[KM] context\\)//'"'"'" }'
fi
