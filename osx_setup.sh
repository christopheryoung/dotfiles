#!/bin/bash

# Requirements:
# First install skim manually
# Then install mactex
# TODO: Bail if not /Applications/Skim.app

#Script for setting up a mac. Assumes that setup.sh has already moved
#dotfiles to appropriate places

#Setup locate
sudo /usr/libexec/locate.updatedb

########################################
#Homebrew stuff
########################################

#Make sure permissions on /usr/local are ok
chown -R `whoami` /usr/local

type brew >/dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

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
type dos2unix >/dev/null 2>&1 || brew install dos2unix
