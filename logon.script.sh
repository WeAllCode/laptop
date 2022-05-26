#!/usr/bin/env bash

updateDock() {
    output "Updating Dock"
    dockutil --remove all
    dockutil --add /Applications/Google\ Chrome.app
    dockutil --add /Applications/Firefox.app
    dockutil --add /Applications/Visual\ Studio\ Code.app
}

setBackground() {
    desktopPictureLocation="$HOME/Pictures/weallcode-background.png"
    desktopPictureURL="https://raw.githubusercontent.com/WeAllCode/linux-update/master/usr/share/backgrounds/weallcode-background.png"

    output "Download background"
    curl -o "$desktopPictureLocation" "$desktopPictureURL"

    output "Setting background"
    osascript -e "tell application \"System Events\" to set picture of every desktop to \"$desktopPictureLocation\""
}

updateDock
setBackground
