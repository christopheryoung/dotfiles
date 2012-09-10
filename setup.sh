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
files="bashrc bash_profile emacs hgrc screenrc viper vimrc git-completion.sh gitignore osx functions aliases jslintrc"

echo "Creating symbolic links in home directory"
for file in $files; do
    rm ~/.$file
    echo "Creating symbolic link to .$file to home directory."
    ln -s $SETUP_SCRIPT_DIR_PATH/.$file ~/.$file
done

#gitconfig has special stuff, so we copy it over
cp $SETUP_SCRIPT_DIR_PATH/.gitconfig ~/

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
#Python stuff
########################################

echo "Checking for sitewide python packages."

type pip >/dev/null 2>&1 || sudo easy_install pip
type virtualenv >/dev/null 2>&1 || pip install virtualenv
type ipython >/dev/null 2>&1 || pip install ipython

type grin >/dev/null 2>&1 || sudo easy_install grin

sudo easy_install readline #note easy_install, not pip


########################################
#Leiningen
########################################

echo "Setting up .lein"

type lein2 >/dev/null 2>&1 || wget --no-check-certificate -O ~/bin/lein2 https://raw.github.com/technomancy/leiningen/preview/bin/lein && chmod 755 ~/bin/lein2

rm -rf ~/.lein
ln -s $SETUP_SCRIPT_DIR_PATH/lein ~/.lein
