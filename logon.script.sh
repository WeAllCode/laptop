#!/bin/bash

# Set Background
automator -i /Users/Shared/weallcode-background.png /Users/Shared/setDesktopWallpaper.workflow

# ---------------------------------------------

# Open Survey
open https://wac.fyi/survey

# ---------------------------------------------

# Update Dock
# don't set background and update dock back to back, they seem to cause a race condition as they restart the dock/desktop
/usr/local/bin/dockutil --remove all \
    --add /Applications/Google\ Chrome.app \
    --add /Applications/Firefox.app \
    --add /Applications/Visual\ Studio\ Code.app \
    --add /Applications/Unity/Unity.app
