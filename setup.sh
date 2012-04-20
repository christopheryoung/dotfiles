#!/bin/bash
############################
#Sets up my environment, including dot files
############################

########## Variables

SETUP_SCRIPT_DIR_PATH=`dirname "$0"`
SETUP_SCRIPT_DIR_PATH=`( cd "$MY_PATH" && pwd )`

BACKUP_DIR=~/archive/dotfiles_old

# list of files/folders to copy to homedir
files="bashrc bash_profile emacs hgrc screenrc viper vimrc git-completion.sh gitconfig gitignore osx functions aliases"

##########

# create dotfiles_old in homedir

if [ ! -d $BACKUP_DIR ]; then
    echo "Creating $BACKUP_DIR for backup of any existing dotfiles in ~"
    mkdir -p $BACKUP_DIR
    echo "Created backup dir"
fi

cd $SETUP_SCRIPT_DIR_PATH

echo "Moving selected dotfiles from ~ to $BACKUP_DIR"
for file in $files; do
    echo "Backing up old .$file to $BACKUP_DIR"
    mv ~/.$file $BACKUP_DIR
    echo "Copying new .$file to home directory."
    cp -f $SETUP_SCRIPT_DIR_PATH/.$file ~/.$file
done

echo "Stitching together .gitconfig file with local private info"
cat ~/.git_private >> ~/.gitconfig

echo "Setting up .emacs.d"
./emacs_setup.sh
