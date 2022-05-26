#!/usr/bin/env bash

GITHUB_REPO="https://raw.githubusercontent.com/WeAllCode/laptop/master"

output() {
    printf "\n\n✅ %s\n" "$1"
}

enableGuestAccount() {
    output "Enabling guest account"
    sudo sysadminctl -guestAccount on
}

setAutoLoginUser() {
    output "Setting auto-login user"
    sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser -string "Guest"
}

installHomebrew() {
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null; then
        output "Installing Homebrew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        output "Homebrew already installed"
    fi
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

    echo "alias python=/usr/local/bin/python3" >>"$HOME/.zshrc"
    echo "alias pip=/usr/local/bin/pip3" >>"$HOME/.zshrc"

    source "$HOME/.zshrc"
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
    brew install --cask hpedrorodrigues/tools/dockutil
}

# updateDock() {
#     output "Updating Dock"
#     dockutil --remove all
#     dockutil --add /Applications/Google\ Chrome.app
#     dockutil --add /Applications/Firefox.app
#     dockutil --add /Applications/Visual\ Studio\ Code.app
# }

# setBackground() {
#     desktopPictureLocation="$HOME/Pictures/weallcode-background.png"
#     desktopPictureURL="$GITHUB_REPO/weallcode-background.png"

#     output "Download background"
#     curl -o "$desktopPictureLocation" "$desktopPictureURL"

#     output "Setting background"
#     osascript -e "tell application \"System Events\" to set picture of every desktop to \"$desktopPictureLocation\""
# }

setLogonScript() {
    logonScriptLocation="/Users/Shared/logon.script.sh"
    logonScriptURL="$GITHUB_REPO/logon.script.sh"

    output "Download logon script"
    sudo curl -o "$logonScriptLocation" "$logonScriptURL"
    sudo chown root:wheel "$logonScriptLocation"

    logonPlistLocation="/Library/LaunchAgents/org.weallcode.logon.plist"
    logonPlistURL="$GITHUB_REPO/org.weallcode.logon.plist"

    output "Download logon plist"
    sudo curl -o "$logonPlistLocation" "$logonPlistURL"

    output "Enabling logon plist"
    sudo chown root "$logonPlistLocation"
    sudo launchctl load "$logonPlistLocation"
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
