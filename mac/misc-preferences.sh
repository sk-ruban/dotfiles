#!/bin/zsh

# Adapted from jonwest/dotfiles
# ╔════════════════════╗
# ║ Set Miscellaneous  ║
# ║    Preferences     ║
# ╚════════════════════╝

# Disable personalized ads
defaults write NSGlobalDomain com.apple.AdLib.allowApplePersonalizedAdvertising -int 0;

# Disable spotlight search keyboard shortcut
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; value = { parameters = (32, 49, 1048576); type = standard; }; }"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
