#!/bin/bash

GITHUB_REPO="https://raw.githubusercontent.com/WeAllCode/laptop/main"

# ---------------------------------------------

# Add VS Code settings.json file to user settings
CODE_SETTINGS_LOCATION="/Users/Guest/Library/Application Support/Code/User/settings.json"

# Download settings.json
curl -fsSL "$GITHUB_REPO/settings.json" -o "$CODE_SETTINGS_LOCATION"

# ---------------------------------------------

# Install VS Code Extensions
code --install-extension ms-python.python

# Upgrade pip
python3 -m pip install --upgrade --force-reinstall pip

# Install python packages
python3 -m pip install --upgrade --force-reinstall weallcode_robot
pip3 install --upgrade --force-reinstall weallcode_robot

# ---------------------------------------------

# Update zsh prompt
ZSHRC_LOCATION="/Users/Guest/.zshrc"
curl -fsSL "$GITHUB_REPO/.zshrc" -o "$ZSHRC_LOCATION"

# ---------------------------------------------

# Open Survey
SURVEY_URL="https://wac.fyi/survey"
open "$SURVEY_URL"

# ---------------------------------------------

sleep 1

# Update Dock
# don't set background and update dock back to back, they seem to cause a race condition as they restart the dock/desktop
/usr/local/bin/dockutil --remove all \
    --add /Applications/Google\ Chrome.app \
    --add /Applications/Visual\ Studio\ Code.app \
    --add /Applications/Unity/Unity.app

# ---------------------------------------------

sleep 1

# Set Background
BACKGROUND_URL="$GITHUB_REPO/weallcode-background.png"
BACKGROUND_LOCATION="/Users/Shared/weallcode-background.png"

curl -fsSL "$BACKGROUND_URL" -o "$BACKGROUND_LOCATION"
wallpaper set "$BACKGROUND_LOCATION"

# ---------------------------------------------
