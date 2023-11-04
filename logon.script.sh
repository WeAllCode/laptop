#!/bin/bash

GITHUB_REPO="https://raw.githubusercontent.com/WeAllCode/laptop/main"

# ---------------------------------------------

# Set Background
automator -i /Users/Shared/weallcode-background.png /Users/Shared/setDesktopWallpaper.workflow

# ---------------------------------------------

# Add VS Code settings.json file to user settings
codeSettingsLocation="/Users/Shared/Library/Application Support/Code/User/settings.json"

# Download settings.json
output "Downloading VS Code settings.json"
sudo curl -fsSL "$GITHUB_REPO/settings.json" -o "$codeSettingsLocation"

# ---------------------------------------------

# Install VS Code Extensions
code --install-extension ms-python.python

# Install python packages
pip install --upgrade weallcode_robot
pip3 install --upgrade weallcode_robot

# ---------------------------------------------

# Update zsh prompt
output "Updating zsh prompt"
sudo curl -fsSL "$GITHUB_REPO/.zshrc" -o "/Users/Shared/.zshrc"

# ---------------------------------------------

# Open Survey
open https://wac.fyi/survey

# ---------------------------------------------

sleep 1

# Update Dock
# don't set background and update dock back to back, they seem to cause a race condition as they restart the dock/desktop
/usr/local/bin/dockutil --remove all \
    --add /Applications/Google\ Chrome.app \
    --add /Applications/Firefox.app \
    --add /Applications/Visual\ Studio\ Code.app \
    --add /Applications/Unity/Unity.app
