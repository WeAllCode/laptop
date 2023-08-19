#!/bin/bash

# Update Dock
/usr/local/bin/dockutil --remove all \
    --add /Applications/Google\ Chrome.app \
    --add /Applications/Firefox.app \
    --add /Applications/Visual\ Studio\ Code.app \
    --add /Applications/Unity/Unity.app

# ---------------------------------------------

# Open Survey
open https://wac.fyi/survey

# ---------------------------------------------

# Set Background
automator -i /Users/Shared/weallcode-background.png /Users/Shared/setDesktopWallpaper.workflow
