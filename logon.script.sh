#!/bin/bash

# Update Dock
# don't set background before updating the dock, it makes the dock update not work sometimes
/usr/local/bin/dockutil --remove all \
    --add /Applications/Google\ Chrome.app \
    --add /Applications/Firefox.app \
    --add /Applications/Visual\ Studio\ Code.app \
    --add /Applications/Unity/Unity.app

# ---------------------------------------------

# Set Background
automator -i /Users/Shared/weallcode-background.png /Users/Shared/setDesktopWallpaper.workflow

# ---------------------------------------------

# Open Survey
open https://wac.fyi/survey
