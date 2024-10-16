#!/bin/zsh

# Adapted from jonwest/dotfiles
# ╔════════════════════╗
# ║     Set Finder     ║
# ║    Preferences     ║
# ╚════════════════════╝                                             

echo -e "Setting up Finder preferences...\n\n"

echo "Disable showing the status bar..."
defaults write com.apple.finder ShowStatusBar -bool false
echo -e "\tFinder status bar disabled!\n"

echo "Enable always showing the path bar..."
defaults write com.apple.finder ShowPathbar -bool true
echo -e "\tPath bar always visible!\n"

echo "Setting 'Keep folders on top when sorting by name'..."
defaults write com.apple.finder _FXSortFoldersFirst -bool true
echo -e "\tFolders displayed on top set!\n"

echo "Disabling the warning when changing a file extension..."
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
echo -e "\tExtension changing warning disabled!\n"

echo "Avoid creating .DS_Store files on network or USB volumes..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Setting default Finder location to home folder..."
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
echo -e "\tDefault Finder location set to home folder!\n"

echo "Enable spring loading for directories..."
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
echo -e "\tSpring loading enabled for directories!\n"

echo "Remove the spring loading delay for directories..."
defaults write NSGlobalDomain com.apple.springing.delay -float 0
echo -e "\tSpring loading delay removed!\n"

echo "Restarting Finder to apply changes..."
killall Finder
echo -e "Finder preferences set up complete!\n"
