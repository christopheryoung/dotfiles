#!/bin/bash

# Manual installs:
  # Emacs: emacsforosx.com
  # skim
  # mactex
  # XQuartz: https://xquartz.macosforge.org
  # Haskell Platform

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

type brew >/dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

xcode-select --install

brew update

brew install Xpdf
brew install aspell
brew install ccache
brew install cloc
brew install coreutils
brew install dos2unix
brew install doxygen
brew install findutils
brew install fzf
brew install imagemagick
brew install nodejs
brew install tmux
brew install tree
brew install wget
brew install yank

echo "Outdated brew packages below: "
brew outdated
