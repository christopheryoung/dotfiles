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

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

xcode-select --install

# tmux plugins
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew update

brew install Xpdf
brew install aspell
brew install bib-tool
brew install ccache
brew install cloc
brew install coreutils
brew install dos2unix
brew install doxygen
brew install fd
brew install findutils
brew install fzf
brew install imagemagick
brew install nodejs
brew install pandoc
brew install pandoc-citeproc
brew install --cask mactex
brew install ripgrep
brew install stack
brew install tmux
brew install tree
brew install wget
brew install yank
brew install bat
brew install monolith
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

$(brew --prefix)/opt/fzf/install

echo "Outdated brew packages below: "
brew outdated
