#!/bin/bash

#Script for setting up a mac. Assumes that setup.sh has already moved
#dotfiles to appropriate places

#Setup locate
sudo /usr/libexec/locate.updatedb

########################################
#Homebrew stuff
########################################

#Make sure permissions on /usr/local are ok
chown -R `whoami` /usr/local

type brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"

brew update
brew upgrade

brew install coreutils

type wget >/dev/null 2>&1 || brew install wget
type aspell >/dev/null 2>&1 || brew install aspell
type findutils >/dev/null 2>&1 || brew install findutils
type go >/dev/null 2>&1 || brew install go
type erlang >/dev/null 2>&1 || brew install erlang
type cabal >/dev/null 2>&1 || brew install cabal
type node >/dev/null 2>&1 || brew install nodejs
type npm >/dev/null 2>&1 || curl https://npmjs.org/install.sh | sh
