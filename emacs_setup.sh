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

########################################
#Backup .emacs.d
########################################
cd $SETUP_SCRIPT_DIR_PATH

if [ -d $EMACSD ]; then
    echo "Backing up old .emacs.d"
    cp -rf $EMACSD $BACKUP_DIR
else 
    echo "No ~/.emacs.d found to back up"
fi

########################################
#Copy and checkout
########################################

# copy the vendor dir for any emacs packages which aren't
# available on elpa or marmalade or via el-get

echo "Copying repo vendor to ~/.emacs.d"
cp -rf $VENDOR_REPO $EMACSD/
