#!/bin/zsh

#  ███╗   ███╗ █████╗  ██████╗ ██████╗ ███████╗
#  ████╗ ████║██╔══██╗██╔════╝██╔═══██╗██╔════╝
#  ██╔████╔██║███████║██║     ██║   ██║███████╗
#  ██║╚██╔╝██║██╔══██║██║     ██║   ██║╚════██║
#  ██║ ╚═╝ ██║██║  ██║╚██████╗╚██████╔╝███████║
#  ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
#  ███████╗███████╗████████╗██╗   ██╗██████╗   
#  ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗  
#  ███████╗█████╗     ██║   ██║   ██║██████╔╝  
#  ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝   
#  ███████║███████╗   ██║   ╚██████╔╝██║       
#  ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝       
#                                              

# Set the current directory as the base path
BASE_DIR=$(dirname "$0")

echo -n "This script will modify system preferences. Continue? (y/n) "
read -r REPLY
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Operation cancelled."
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo privileges. Exiting..."
   exit 1
fi

echo "Running all preference scripts..."

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
echo "Closing System Preferences..."
osascript -e 'tell application "System Preferences" to quit'

# Source each script
echo "Running dock preferences..."
source "$BASE_DIR/dock-preferences.sh"

echo "Running finder preferences..."
source "$BASE_DIR/finder-preferences.sh"

echo "Running misc preferences..."
source "$BASE_DIR/misc-preferences.sh"

echo "All preference scripts have been executed."
