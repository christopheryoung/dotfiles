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
sudo /usr/libexec/locate.updatedb

########################################
#Homebrew stuff
########################################

#Make sure permissions on /usr/local are ok
sudo chown -R `whoami` /usr/local

type brew >/dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

brew update

brew install coreutils
brew install ccache
brew install aspell
brew install findutils
brew install nodejs
brew install dos2unix
brew install imagemagick
brew install wget

echo "Outdated brew packages below: "
brew outdated
