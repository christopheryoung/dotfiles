#!/bin/bash
############################
#Sets up my environment, including dot files
############################

########## Variables

SETUP_SCRIPT_DIR_PATH=`dirname "$0"`
SETUP_SCRIPT_DIR_PATH=`( cd "$MY_PATH" && pwd )`

BACKUP_DIR=~/archive/dotfiles_old
VENDOR_REPO=$SETUP_SCRIPT_DIR_PATH/vendor
VENDOR_EMACS=~/.emacs.d/vendor

# list of files/folders to copy to homedir
files="bashrc bash_profile emacs hgrc screenrc viper vimrc git-completion.sh gitconfig gitignore osx functions aliases"

##########

# create dotfiles_old in homedir
echo "Creating $BACKUP_DIR for backup of any existing dotfiles in ~"
if [ ! -d $BACKUP_DIR ]; then
    mkdir -p $BACKUP_DIR
    echo "Created backup dir"
fi

# change to the dotfiles directory
echo "Changing to the $SETUP_SCRIPT_DIR_PATH directory"
cd $SETUP_SCRIPT_DIR_PATH
echo "...done"

echo "Moving selected dotfiles from ~ to $BACKUP_DIR"
for file in $files; do
    mv ~/.$file $BACKUP_DIR
    echo "Copying $file to home directory."
    cp -f $SETUP_SCRIPT_DIR_PATH/.$file ~/.$file
done

# copy the vendor dir for any emacs packages which aren't
# available on elpa or marmalade

if [ -d $VENDOR_EMACS ]; then
    echo "Moving any existing vendor files to backup"
    mv -f $VENDOR_EMACS $BACKUP_DIR
fi

mkdir -p $VENDOR_EMACS

echo "Copying emacs vendor dir to repo vendor dir"
cp -rf ~/.emacs.d $BACKUP_DIR

echo "Stitching together .gitconfig file with local private info"
cat ~/.git_private >> ~/.gitconfig
