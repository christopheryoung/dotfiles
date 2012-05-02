#!/bin/bash

#Script for setting up a mac. Assumes that setup.sh has already moved
#dotfiles to appropriate places


########################################
#Homebrew stuff
########################################

#Make sure permissions on /usr/local are ok
sudo chown -R `whoami` /usr/local

type brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"

brew update
brew upgrade

type wget >/dev/null 2>&1 || brew install wget
type aspell >/dev/null 2>&1 || brew install aspell

########################################
#Mac specific stuff
########################################

easy_install readline
