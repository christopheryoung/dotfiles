
#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired
#dotfiles in ~/dotfiles

# Adapted from here: https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
############################

########## Variables

repo_dir=~/code/dotfiles                    # dotfiles directory
backup_dir=~/archive/dotfiles_old             # old dotfiles backup directory
vendor_repo=~/code/dotfiles/vendor
vendor_emacs=~/.emacs.d/vendor
files="bashrc bash_profile emacs hgrc screenrc viper vimrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $backup_dir for backup of any existing dotfiles in ~"
if [ ! -d $backup_dir ]; then
    mkdir -p $backup_dir
    echo "Created backup dir"
fi

# change to the dotfiles directory
echo "Changing to the $repo_dir directory"
cd $repo_dir
echo "...done"

for file in $files; do
    echo "Moving selected dotfiles from ~ to $backup_dir"
    mv ~/.$file $backup_dir
    echo "Copying $file to home directory."
    cp -f $repo_dir/.$file ~/.$file
done

# copy the vendor dir for any emacs packages which aren't
# available on elpa or marmalade

if [ -d $vendor_emacs ]; then
    echo "Moving any existing vendor files to backup"
    mv -f $vendor_emacs $backup_dir
fi

echo "Copying emacs vendor dir to repo vendor dir"
cp -r $vendor_repo ~/.emacs.d

