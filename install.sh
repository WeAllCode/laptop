#!/usr/bin/env bash

output() {
    printf "\n\n✅ %s\n" "$1"
}

enableGuestAccount() {
    output "Enabling guest account"
    sudo sysadminctl -guestAccount off
}

setAutoLoginUser() {
    output "Setting auto-login user"
    sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser -string "Guest"
}

installHomebrew() {
    output "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

disableHomebrewAnalytics() {
    output "Disabling Homebrew analytics"
    brew analytics off
}

updateBrew() {
    output "Updating Homebrew"
    brew update
}

installGoogleChrome() {
    output "Installing Google Chrome"
    brew install --cask google-chrome
}

installFirefox() {
    output "Installing Firefox"
    brew install --cask firefox
}

installVSCode() {
    output "Installing VSCode"
    brew install --cask visual-studio-code
}

installGit() {
    output "Installing Git"
    brew install git
}

installVim() {
    output "Installing Vim"
    brew install vim
}

installPython() {
    output "Installing Python"
    brew install python
}

installNode() {
    output "Installing Node"
    brew install node
}

installXCode() {
    output "Installing XCode"
    xcode-select --install
}

installNextDNS() {
    output "Installing NextDNS"
    brew install nextdns/tap/nextdns

    output "Configuring NextDNS"
    sudo nextdns install \
        -config "e8fcc6" \
        -report-client-info \
        -auto-activate

}

installDockutil() {
    output "Installing Dockutil"
    brew install dockutil
}

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

enableGuestAccount
setAutoLoginUser
installHomebrew
disableHomebrewAnalytics
updateBrew
installGoogleChrome
installFirefox
installVSCode
installGit
installVim
installPython
installNode
installXCode
installNextDNS
installDockutil
updateDock
setBackground
