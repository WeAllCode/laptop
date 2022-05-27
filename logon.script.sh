#!/bin/bash

say "Going to sleep."

sleep 30

say "Sleep over."

# updateDock
/usr/local/bin/dockutil --remove all --add /Applications/Google\ Chrome.app --add /Applications/Firefox.app --add /Applications/Visual\ Studio\ Code.app

say "Dock updated."

# setBackground
desktopPictureLocation="/Users/Shared/weallcode-background.png"
desktopPictureURL="https://raw.githubusercontent.com/WeAllCode/linux-update/master/usr/share/backgrounds/weallcode-background.png"

/usr/bin/curl -o "$desktopPictureLocation" "$desktopPictureURL"

say "Wallpaper downloaded."

/usr/bin/osascript -e "tell application \"System Events\" to set picture of every desktop to \"$desktopPictureLocation\""

say "Wallpaper set."
