#!/usr/bin/env bash
#
# To install:
#
# /bin/bash -c "$(curl -fsSL wac.fyi/mac)"
#

{ # this ensures the entire script is downloaded #

    GITHUB_REPO="https://raw.githubusercontent.com/WeAllCode/laptop/main"

    output() {
        printf "\n\n✅ %s\n" "$1"
        say -r 300 "$1"
    }

    # install all software updates
    runSoftwareUpdate() {
        output "Installing software updates"
        sudo softwareupdate -i -a
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

        output "Uninstall nextdns"
        brew uninstall nextdns

        output "Uninstall firefox"
        brew uninstall firefox
    }

    upgradeBrew() {
        output "Upgrading Homebrew"
        brew upgrade --greedy
    }

    removeOldTapsInBrew() {
        brew untap homebrew/core
        brew untap homebrew/cask
    }

    installGoogleChrome() {
        # Install Google Chrome
        output "Installing Google Chrome"
        brew reinstall --cask --force google-chrome
    }

    installVSCode() {
        # Install Visual Studio Code
        output "Installing Visual Studio Code"
        brew reinstall --cask --force visual-studio-code
    }

    installGit() {
        # Install Git if not installed
        if ! command -v git >/dev/null; then
            output "Installing Git"
            brew install git
        else
            output "Git already installed"
        fi
    }

    installVim() {
        # Install Vim if not installed
        if ! command -v vim >/dev/null; then
            output "Installing Vim"
            brew install vim
        else
            output "Vim already installed"
        fi
    }

    installPython() {
        # Install Python if not installed
        if ! command -v python3 >/dev/null; then
            output "Installing Python"
            brew install python

            echo "alias python=/usr/local/bin/python3" >>"$HOME/.zshrc"
            echo "alias pip=/usr/local/bin/pip3" >>"$HOME/.zshrc"
            source "$HOME/.zshrc"
        else
            output "Python already installed"
        fi
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

    installPurePrompt() {
        # Install Pure Prompt if not installed
        output "Installing Pure Prompt"
        npm install --global pure-prompt
    }

    installXCode() {
        # Install XCode if not installed
        if ! command -v xcode-select >/dev/null; then
            output "Installing XCode"
            # brew install mas
            # mas install 497799835
            xcode-select --install
        else
            output "XCode already installed"
        fi
    }

    # Install unity
    installUnity() {
        # Install Unity
        output "Installing Unity"
        brew install --cask unity
    }

    installDockutil() {
        # Install dockutil
        output "Installing dockutil"
        brew reinstall --cask hpedrorodrigues/tools/dockutil
    }

    installPythonPackage() {
        pip install --upgrade weallcode_robot
        pip3 install --upgrade weallcode_robot
    }

    updateDock() {
        output "Updating Dock"
        dockutil --remove all \
            --add /Applications/Google\ Chrome.app \
            --add /Applications/Visual\ Studio\ Code.app \
            --add /Applications/Unity/Unity.app
    }

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

        automatorZipLocation="/Users/Shared/setDesktopWallpaper.workflow.zip"
        automatorLocation="/Users/Shared/setDesktopWallpaper.workflow"
        automatorURL="$GITHUB_REPO/setDesktopWallpaper.workflow.zip"

        sudo curl -fsSL "$automatorURL" -o "$automatorZipLocation"

        sudo unzip -o "$automatorZipLocation" -d "/Users/Shared"
        sudo chown root "$automatorZipLocation"
        sudo rm "$automatorZipLocation"

        sudo chown -R root "$automatorLocation"
        sudo chmod -R +x "$automatorLocation"

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

    # runSoftwareUpdate # Runs slow
    enableGuestAccount
    setAutoLoginUser
    installHomebrew
    disableHomebrewAnalytics
    installXCode
    updateBrew
    removeOldTapsInBrew
    installGoogleChrome
    installVSCode
    installGit
    installVim
    installPython
    installNode
    installPurePrompt
    #installUnity
    installDockutil
    upgradeBrew
    installPythonPackage
    updateDock
    setBackground
    setLogonScript

}
