#!/bin/bash
################################################################################
#Sets up my environment, including dot files
################################################################################


########################################
#Directories
########################################

SETUP_SCRIPT_DIR_PATH=`dirname "$0"`
SETUP_SCRIPT_DIR_PATH=`( cd "$MY_PATH" && pwd )`

########################################
#Dotfiles
########################################

# list of files/folders to copy to homedir
files="bashrc bash_profile emacs hgrc screenrc viper vimrc git-completion.sh gitignore osx functions aliases"

echo "Creating symbolic links in home directory"
for file in $files; do
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
