#!/bin/zsh

# ╔════════════════════╗
# ║  Set up Keyboard   ║
# ║    Preferences     ║
# ╚════════════════════╝

echo -e "Setting Keyboard preferences...\n\n"

# System Settings > Keyboard > Key repeat rate: Fast (UI maximum)
echo "Setting key repeat rate..."
defaults write -g KeyRepeat -int 2
echo -e "\tKey repeat rate set! \n"

# System Settings > Keyboard > Delay until repeat: Short (UI minimum)
echo "Setting delay until repeat..."
defaults write -g InitialKeyRepeat -int 15
echo -e "\tDelay until repeat set! \n"

echo "Log out and back in for changes to take effect."
