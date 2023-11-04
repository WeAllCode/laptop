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

    disableAutoLoginUser() {
        output "Disabling auto-login user"
        sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
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

    tapHomebrew() {
        output "Tapping $1"
        brew tap "$1"
    }

    brewCaskPin() {
        output "Pinning $1"
        brew cu pin "$2"
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
        brew cu --yes
    }

    removeOldTapsInBrew() {
        brew untap homebrew/core
        brew untap homebrew/cask
    }

    brewInstall() {
        NAME=$1
        FORMULA_NAME=$2
        SPECIFIC_URL=$3

        # Check if $NAME is installed
        if ! brew list -1 | grep "^$FORMULA_NAME$" >/dev/null; then
            output "Installing $NAME"

            if [ -z "$SPECIFIC_URL" ]; then
                brew install "$FORMULA_NAME"
            else
                # shellcheck disable=2086
                brew install $SPECIFIC_URL
            fi

        else
            output "Upgrading $NAME"

            if [ -z "$SPECIFIC_URL" ]; then
                brew upgrade "$FORMULA_NAME"
            else
                # shellcheck disable=2086
                brew upgrade $SPECIFIC_URL
            fi

        fi
    }

    installPurePrompt() {
        # Install Pure Prompt if not installed
        output "Installing Pure Prompt"
        npm install --global pure-prompt
    }

    updateZshRC() {
        output "Updating .zshrc"
        curl -fsSL "$GITHUB_REPO/.zshrc" -o "$HOME/.zshrc"
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

    installPythonPackage() {
        # Upgrade pip
        output "Upgrade pip"
        python3 -m pip install --upgrade --force-reinstall pip

        # Install python packages
        output "Install python packages"
        python3 -m pip install --upgrade --force-reinstall weallcode_robot
        pip3 install --upgrade --force-reinstall weallcode_robot
    }

    updateDock() {
        output "Updating Dock"
        dockutil --remove all \
            --add /Applications/Google\ Chrome.app \
            --add /Applications/Visual\ Studio\ Code.app \
            --add /Applications/Unity/Unity.app
    }

    setLogonScript() {
        logonScriptLocation="/Users/Shared/logon.script.sh"
        logonScriptURL="$GITHUB_REPO/logon.script.sh"

        output "Downloading logon script"
        sudo curl -fsSL "$logonScriptURL" -o "$logonScriptLocation"

        sudo chown root "$logonScriptLocation"
        sudo chmod +x "$logonScriptLocation"

        # ---------------------------------------------

        logonPlistLocation="/Library/LaunchAgents/org.weallcode.logon.plist"
        logonPlistURL="$GITHUB_REPO/org.weallcode.logon.plist"

        # Download logon plist
        output "Downloading logon plist"
        sudo curl -fsSL "$logonPlistURL" -o "$logonPlistLocation"

        if launchctl list | grep -q "org.weallcode.logon"; then
            output "Unloading org.weallcode.logon"
            sudo launchctl unload -w "$logonPlistLocation"
            launchctl unload -w "$logonPlistLocation"
        fi

        output "Enabling logon plist"
        sudo chown root "$logonPlistLocation"
        sudo launchctl load -w "$logonPlistLocation"
        launchctl load -w "$logonPlistLocation"
    }

    # runSoftwareUpdate # Runs slow
    enableGuestAccount
    # setAutoLoginUser # disabled for now
    disableAutoLoginUser

    installHomebrew
    disableHomebrewAnalytics
    installXCode

    updateBrew
    removeOldTapsInBrew

    tapHomebrew "buo/cask-upgrade" # brew cu

    brewInstall "Google Chrome" "google-chrome"
    brewInstall "Visual Studio Code" "visual-studio-code"
    brewInstall "Git" "git"
    brewInstall "Vim" "vim"
    brewInstall "Wallpaper Changer" "wallpaper"
    brewInstall "Python 3.x" "python3"
    brewInstall "Node" "node"
    brewInstall "Unity" "unity" "--cask https://raw.githubusercontent.com/Homebrew/homebrew-cask/4dc5194f3806a9b10a289cf4eaf68f7eb5528691/Casks/unity.rb" # 2022.1.23f1,9636b062134a
    brewCaskPin "Unity" "unity"

    tapHomebrew "hpedrorodrigues/tools"
    brewInstall "Dockutil" "hpedrorodrigues/tools/dockutil"

    installPurePrompt
    updateZshRC

    upgradeBrew
    installPythonPackage
    updateDock
    setLogonScript
}
