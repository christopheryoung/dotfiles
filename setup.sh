#!/bin/bash
################################################################################
#Sets up my environment, including dot files
################################################################################


########################################
#Directories
########################################

SETUP_SCRIPT_DIR_PATH=`( cd "$MY_PATH" && pwd )`

########################################
#Dotfiles
########################################

# list of files/folders to copy to homedir
files="bashrc bash_profile emacs hgrc screenrc viper vimrc git-completion.sh osx functions aliases jslintrc inputrc ghci pylintrc"

echo "Creating symbolic links in home directory"
for file in $files; do
    rm ~/.$file
    echo "Creating symbolic link to .$file to home directory."
    ln -s $SETUP_SCRIPT_DIR_PATH/.$file ~/.$file
done

rm ~/.gitignore
ln -s $SETUP_SCRIPT_DIR_PATH/gitignore ~/.gitignore

#gitconfig has special stuff, so we copy it over
cp -f $SETUP_SCRIPT_DIR_PATH/gitconfig ~/.gitconfig

########################################
#Privacy preserving dotfiles surgery
########################################

echo "Stitching together .gitconfig file with local private info"
cat ~/.git_private >> ~/.gitconfig

########################################
#.emacs.d
########################################

rm -rf ~/.emacs.d
ln -s $SETUP_SCRIPT_DIR_PATH/emacs.d ~/.emacs.d

#########################################
# Haskell
#########################################
curl -sSL https://get.haskellstack.org/ | sh


echo "Done!"
