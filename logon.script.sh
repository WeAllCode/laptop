#!/bin/bash

# Set Background
desktopPictureLocation="/Users/Shared/weallcode-background.png"
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '${desktopPictureLocation}'"

# Update Dock
/usr/local/bin/dockutil --remove all --add /Applications/Google\ Chrome.app --add /Applications/Firefox.app --add /Applications/Visual\ Studio\ Code.app

# Kill Dock
killall Dock
