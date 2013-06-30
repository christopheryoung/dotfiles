
# Emacs 24
sudo apt-get update
sudo apt-get install
sudo apt-get purge emacs-snapshot-common emacs-snapshot-bin-common emacs-snapshot emacs-snapshot-el emacs-snapshot-gtk emacs23 emacs23-bin-common emacs23-common emacs23-el emacs23-nox emacs23-lucid auctex emacs24 emacs24-bin-common emacs24-common emacs24-common-non-dfsg

sudo apt-get install software-properties-common 
sudo su
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get install emacs-snapshot

# Python
#sudo apt-get install python-setuptools

#
sudo apt-get install git 

sudo apt-get install screen

sudo apt-get install haskell-platform

sudo apt-get install postgresql
sudo apt-get install postgresql-server-dev-all

# haskell stuff
cabal update
cabal install cabal-install
cabal install yesod-platform
cabal install yesod-bin


