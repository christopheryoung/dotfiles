#!/bin/bash

#Script for setting up a mac. Assumes that setup.sh has already moved
#dotfiles to appropriate places


############################
#Install software
###########################

#homebrew
if type -p brew; then
    echo "homebrew already installed . . . skipping install"
else
    /usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
fi

#leinigen
if type -p lein; then
    echo "leinigen already installed . . . skipping install"
else
    echo "installing leinigen"
    curl -O https://raw.github.com/technomancy/leiningen/stable/bin/lein
    mkdir ~/bin
    mv lein ~/bin
    chmod 755 ~/bin/lein
    lein
fi

#aspell
if type -p aspell; then
    echo "aspell already installed . . . skipping install"
else
    echo "installing aspell"
    brew install aspell --lang=en
fi

