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
    echo "Creating symbolic link to .$file to home directory."
    ln -s $SETUP_SCRIPT_DIR_PATH/.$file ~/.$file
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

stacktrace_version="0.2.4"
swank_clojure_version="1.4.2"
lein_swank_version="1.4.2"

#TODO: This is nuts. I should either learn shell scripting or just
#rewrite this in Python

if [ ! -f ~/.lein/plugins/clj-stacktrace-$stacktrace_version.jar ]; then
    lein plugin install clj-stacktrace $stacktrace_version
else
    echo "clj-stacktrace-$stacktrace_version already installed"
fi

if [ ! -f ~/.lein/plugins/swank-clojure-$swank_clojure_version.jar ]; then
    lein plugin install swank-clojure $swank_clojure_version
else
    echo "swank-clojure-$swank_clojure_version already installed"
fi

if [ ! -f ~/.lein/plugins/lein-swank-$lein_swank_version.jar ]; then
    lein plugin install lein-swank $lein_swank_version
else
    echo "lein-swank-$lein_swank_version already installed"
fi
