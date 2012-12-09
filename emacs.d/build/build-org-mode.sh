
SCRIPT_DIR_PATH=`( cd "$MY_PATH" && pwd )`
ORG_SOURCE=$SCRIPT_DIR_PATH/org-mode/org-7.9.2
LOCAL_MAKEFILE=$SCRIPT_DIR_PATH/org-makefile.mk

cp -f $LOCAL_MAKEFILE $ORG_SOURCE/local.mk
cd $ORG_SOURCE
sudo make install
sudo make install-info

