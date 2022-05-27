#!/bin/bash

sleep 5

# Update Dock
/usr/local/bin/dockutil --remove all --add /Applications/Google\ Chrome.app --add /Applications/Firefox.app --add /Applications/Visual\ Studio\ Code.app

# Set Background
desktopPictureLocation="/Users/Shared/weallcode-background.png"
/usr/bin/osascript -e "tell application \"System Events\" to set picture of every desktop to \"$desktopPictureLocation\""
