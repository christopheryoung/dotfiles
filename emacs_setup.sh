#!/bin/bash
################################################################################
#Sets up .emacs.d
################################################################################

########################################
#Variables
########################################

SETUP_SCRIPT_DIR_PATH=`dirname "$0"`
SETUP_SCRIPT_DIR_PATH=`( cd "$MY_PATH" && pwd )`
BACKUP_DIR=~/archive/dotfiles_old

VENDOR_REPO=$SETUP_SCRIPT_DIR_PATH/emacs/vendor
EMACSD=~/.emacs.d
EMACSD_VENDOR=$EMACSD/vendor
SNIPPETS_REPO=$SETUP_SCRIPT_DIR_PATH/emacs/snippets
EMACS_SNIPPETS_DIR=$EMACSD/snippets

########################################
#Backup .emacs.d
########################################

if [ ! -d $BACKUP_DIR ]; then
    echo "Creating $BACKUP_DIR for backup of any existing dotfiles in ~"
    mkdir -p $BACKUP_DIR
    echo "Created backup dir"
fi

cd $SETUP_SCRIPT_DIR_PATH

if [ -d $EMACSD ]; then
    echo "Backing up old .emacs.d"
    cp -rf $EMACSD $BACKUP_DIR
else
    echo "No ~/.emacs.d found to back up"
    mkdir $EMACSD
fi

cd $EMACSD

if [ -f extra-loadpaths.el ]; then
    echo "deleting old extra_loadpaths.el"
    rm extra-loadpaths.el
fi

echo "creating new extra_loadpaths.el"
touch extra-loadpaths.el

########################################
#Copy and checkout
########################################

# midje-mode

if [ -d $EMACSD/midje-mode ]; then
    echo "midje-mode already present."
else
    echo "Cloning midje-mode"
    git clone git@github.com:christopheryoung/midje-mode.git
fi

echo "(add-to-list 'load-path \"$EMACSD/midje-mode/\")" >> extra-loadpaths.el


# copy the vendor dir for any emacs packages which aren't
# available on elpa or marmalade or via el-get

echo "Creating symbolic links from ~/.emacs/vendor to vendor repo"
rm -rf $EMACSD_VENDOR
ln -s $VENDOR_REPO $EMACSD_VENDOR

echo "Creating symbolic links from ~/.emacs/snippets to snippets
rm -rf $SNIPPETS_REPO
ln -s $SNIPPET_REPO $EMACS_SNIPPETS_DIR
