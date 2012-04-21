#!/bin/bash
################################################################################
#Sets up my environment, including dot files
################################################################################


########################################
#Directories
########################################

SETUP_SCRIPT_DIR_PATH=`dirname "$0"`
SETUP_SCRIPT_DIR_PATH=`( cd "$MY_PATH" && pwd )`
BACKUP_DIR=~/archive/dotfiles_old

########################################
#Dotfiles
########################################

# list of files/folders to copy to homedir
files="bashrc bash_profile emacs hgrc screenrc viper vimrc git-completion.sh gitconfig gitignore osx functions aliases"

if [ ! -d $BACKUP_DIR ]; then
    echo "Creating $BACKUP_DIR for backup of any existing dotfiles in ~"
    mkdir -p $BACKUP_DIR
    echo "Created backup dir"
fi

echo "Moving selected dotfiles from ~ to $BACKUP_DIR"
for file in $files; do
    echo "Backing up old .$file to $BACKUP_DIR"
    mv ~/.$file $BACKUP_DIR
    echo "Copying new .$file to home directory."
    cp -f $SETUP_SCRIPT_DIR_PATH/.$file ~/.$file
done

########################################
#Privacy preserving dotfiles surgery
########################################

echo "Stitching together .gitconfig file with local private info"
cat ~/.git_private >> ~/.gitconfig

########################################
#.emacs.d
########################################

echo "Setting up .emacs.d"
./emacs_setup.sh

########################################
#Leiningen
########################################

echo "Setting up .lein"
cp -f $SETUP_SCRIPT_DIR_PATH/lein/init.clj ~/.lein/

lein_plugins='clj-stacktrace-0.2.4.jar swank-clojure-1.3.4.jar'

for plugin in $lein_plugins; do
    if [ ! -f ~/.lein/plugins/$plugin ]; then
    echo "Installing $plugin"
    lein plugin install $plugin
    else
        echo "$plugin already installed"
    fi
done
