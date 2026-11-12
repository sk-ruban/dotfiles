#!/bin/zsh

# ╔════════════════════╗
# ║ Set up Rectangle   ║
# ║    Preferences     ║
# ╚════════════════════╝

echo -e "Setting Rectangle preferences...\n\n"

# Rectangle > Settings > Hide menu bar icon
echo "Hiding menu bar icon..."
defaults write com.knollsoft.Rectangle hideMenubarIcon -bool true
echo -e "\tMenu bar icon hidden! \n"

# Rectangle > Settings > Check for updates automatically: off
echo "Disabling automatic update checks..."
defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -bool false
echo -e "\tAutomatic update checks disabled! \n"

# Rectangle > Settings > Default shortcuts: Recommended (not Spectacle)
echo "Setting default shortcuts..."
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true
echo -e "\tDefault shortcuts set! \n"

# Rectangle > Settings > Remove keyboard shortcut restrictions
echo "Removing shortcut restrictions..."
defaults write com.knollsoft.Rectangle allowAnyShortcut -bool true
echo -e "\tShortcut restrictions removed! \n"

# Rectangle > Settings > Repeated commands: move to adjacent display
echo "Setting repeated command behavior..."
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 1
echo -e "\tRepeated command behavior set! \n"

killall Rectangle 2>/dev/null; sleep 1; open -a Rectangle
