#!/bin/zsh

# Adapted from jonwest/dotfiles
# ╔════════════════════╗
# ║    Set up Dock     ║
# ║    Preferences     ║
# ╚════════════════════╝                                             

echo -e "Setting Dock preferences...\n\n"

# System Preferences > Dock > Size:
echo "Setting dock size..."
defaults write com.apple.dock tilesize -int 80
echo -e "\tDock size set! \n"

# System Preferences > Dock > Magnification:
echo "Enabling dock magnification..."
defaults write com.apple.dock magnification -bool true
echo -e "\tDock magnification enabled! \n"

# System Preferences > Dock > Magnification size:
echo "Setting magnification size..."
defaults write com.apple.dock largesize -int 90
echo -e "\tMagnification size set! \n"

# System Preferences > Dock > Minimize windows using: Genie effect
echo "Minimize windows with 'genie' effect..."
defaults write com.apple.dock mineffect -string "genie"
echo -e "\tGenie effect set! \n"

# System Preferences > Dock > Minimize windows into application icon
echo "Setting minimize into application icon behaviour..."
defaults write com.apple.dock minimize-to-application -bool false
echo -e "\tMinimize into application icon disabled! \n"

# System Preferences > Dock > Automatically hide and show the Dock:
echo "Enabling dock auto-hide..."
defaults write com.apple.dock autohide -bool true
echo -e "\tDock auto-hide enabled! \n"

# System Preferences > Dock > Show indicators for open applications
echo "Enabling indicators for open applications..."
defaults write com.apple.dock show-process-indicators -bool true
echo -e "\tOpen application indicators enabled! \n"

# System Preferences > Dock > Remove Recently Opened Applications
echo "Removing recent applications in dock..."
defaults write com.apple.dock show-recents -bool false
echo -e "\tRecent applications will not be shown in dock! \n"

echo "Restarting dock to apply preferences..."
killall "Dock" > /dev/null 2>&1
