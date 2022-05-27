#!/bin/bash

sleep 1m

# updateDock
/usr/local/bin/dockutil --remove all --add /Applications/Google\ Chrome.app --add /Applications/Firefox.app --add /Applications/Visual\ Studio\ Code.app

# setBackground
desktopPictureLocation="/Users/Shared/weallcode-background.png"
desktopPictureURL="https://raw.githubusercontent.com/WeAllCode/linux-update/master/usr/share/backgrounds/weallcode-background.png"

/usr/bin/curl -o "$desktopPictureLocation" "$desktopPictureURL"

/usr/bin/osascript -e "tell application \"System Events\" to set picture of every desktop to \"$desktopPictureLocation\""
