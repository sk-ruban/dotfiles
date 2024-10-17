#!/bin/zsh

# Adapted from jonwest/dotfiles
# ╔════════════════════╗
# ║ Set Miscellaneous  ║
# ║    Preferences     ║
# ╚════════════════════╝

# Disable personalized ads
defaults write NSGlobalDomain com.apple.AdLib.allowApplePersonalizedAdvertising -int 0;

# Disable spotlight search keyboard shortcut
defaults write NSGlobalDomain com.apple.symbolichotkeys.AppleSymbolicHotKeys.64.enabled -int 0;

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
