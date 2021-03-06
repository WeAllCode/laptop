#!/usr/bin/env bash

GITHUB_REPO="https://raw.githubusercontent.com/WeAllCode/laptop/master"

output() {
    printf "\n\n✅ %s\n" "$1"
    say -r 300 "$1"
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
    # Install Google Chrome if not installed
    if ! brew list --cask -1 google-chrome >/dev/null; then
        output "Installing Google Chrome"
        brew install --cask google-chrome
    else
        output "Google Chrome already installed"
    fi
}

installFirefox() {
    # Install Firefox if not installed
    if ! brew list --cask -1 firefox >/dev/null; then
        output "Installing Firefox"
        brew install --cask firefox
    else
        output "Firefox already installed"
    fi
}

installVSCode() {
    # Install Visual Studio Code if not installed
    if ! brew list --cask -1 visual-studio-code >/dev/null; then
        output "Installing Visual Studio Code"
        brew install --cask visual-studio-code
    else
        output "Visual Studio Code already installed"
    fi
}

installGit() {
    # Install Git if not installed
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

    # echo "alias python=/usr/local/bin/python3" >>"$HOME/.zshrc"
    # echo "alias pip=/usr/local/bin/pip3" >>"$HOME/.zshrc"

    # source "$HOME/.zshrc"
}

installNode() {
    # Install Node if not installed
    if ! command -v node >/dev/null; then
        output "Installing Node"
        brew install node
    else
        output "Node already installed"
    fi
}

installXCode() {
    output "Installing XCode"
    # brew install mas
    # mas install 497799835
    # xcode-select --install
}

installNextDNS() {
    # Install NextDNS if not installed
    if ! command -v nextdns >/dev/null; then
        output "Installing NextDNS"
        brew install nextdns/tap/nextdns
    else
        output "NextDNS already installed"
    fi

    output "Configuring NextDNS"
    sudo nextdns install \
        -config "e8fcc6" \
        -report-client-info \
        -auto-activate

}

installDockutil() {
    # Install dockutil if it's not installed
    if ! command -v dockutil >/dev/null; then
        output "Installing dockutil"
        brew install --cask hpedrorodrigues/tools/dockutil
    else
        output "dockutil already installed"
    fi
}

# updateDock() {
#     output "Updating Dock"
#     dockutil --remove all
#     dockutil --add /Applications/Google\ Chrome.app
#     dockutil --add /Applications/Firefox.app
#     dockutil --add /Applications/Visual\ Studio\ Code.app
# }

setBackground() {
    desktopPictureLocation="/Users/Shared/weallcode-background.png"
    desktopPictureURL="https://raw.githubusercontent.com/WeAllCode/linux-update/master/usr/share/backgrounds/weallcode-background.png"

    output "Downloading background"
    curl -o "$desktopPictureLocation" "$desktopPictureURL"

    # output "Setting background"
    # osascript -e "tell application \"System Events\" to set picture of every desktop to \"$desktopPictureLocation\""
}

setLogonScript() {
    logonScriptLocation="/Users/Shared/logon.script.sh"
    logonScriptURL="$GITHUB_REPO/logon.script.sh"

    output "Downloading log on script"
    sudo curl -fsSL "$logonScriptURL" -o "$logonScriptLocation"

    sudo chown root "$logonScriptLocation"
    sudo chmod +x "$logonScriptLocation"

    logonPlistLocation="/Library/LaunchAgents/org.weallcode.logon.plist"
    logonPlistURL="$GITHUB_REPO/org.weallcode.logon.plist"

    # Download logon plist
    output "Downloading log on plist"
    sudo curl -fsSL "$logonPlistURL" -o "$logonPlistLocation"

    output "Enabling log on plist"
    sudo chown root "$logonPlistLocation"
    sudo launchctl load "$logonPlistLocation"
    launchctl load "$logonPlistLocation"

    # # for reference:
    # # ditto -c -k --sequesterRsrc --keepParent weallcode-logon.app weallcode-logon.app.zip

    # logonScriptLocation="/Users/Shared/weallcode-logon.app"
    # logonScriptURL="$GITHUB_REPO/weallcode-logon.app.zip"

    # # download logon script if it doesn't exist
    # if [ ! -f "$logonScriptLocation" ]; then
    #     output "Downloading logon script"
    #     curl -o "$logonScriptLocation.zip" "$logonScriptURL"
    #     ditto -x -k "$logonScriptLocation.zip" "$logonScriptLocation"
    # else
    #     output "Logon script already exists"
    # fi

    # osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$logonScriptLocation\", hidden:false}"

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
# updateDock
setBackground
setLogonScript
