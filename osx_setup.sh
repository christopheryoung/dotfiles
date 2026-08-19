#!/bin/bash

# Manual installs:
  # Emacs: https://emacsformacosx.com
  # Skim
  # XQuartz: https://www.xquartz.org

#Script for setting up a mac. Assumes that setup.sh has already moved
#dotfiles to appropriate places

#Setup locate
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
sudo /usr/libexec/locate.updatedb

########################################
#Homebrew stuff
########################################

#Make sure permissions on /usr/local are ok
sudo chown -R `whoami` /usr/local

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

xcode-select --install

# tmux plugins
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew update

# Package list lives in Brewfile so it can be diffed and re-applied.
brew bundle --file="$(dirname "$0")/Brewfile"

$(brew --prefix)/opt/fzf/install

echo "Outdated brew packages below: "
brew outdated
