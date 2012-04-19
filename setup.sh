
#!/bin/bash
############################
#Sets up my environment, including dot files
############################

########## Variables

repo_dir=~/code/dotfiles                    # dotfiles directory
backup_dir=~/archive/dotfiles_old             # old dotfiles backup directory
vendor_repo=~/code/dotfiles/vendor
vendor_emacs=~/.emacs.d/vendor
# list of files/folders to copy to homedir
files="bashrc bash_profile emacs hgrc screenrc viper vimrc git-completion.sh gitconfig gitignore"

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

mkdir -p $vendor_emacs

echo "Copying emacs vendor dir to repo vendor dir"
cp -r $vendor_repo/* $vendor_emacs

echo "Stitching together .gitconfig file with local private info"
cat ~/.git_private >> ~/.gitconfig

############################
#Install software
###########################

#leinigen
if type -p lein; then
    echo "leinigen already installed . . . skipping install"
else
    echo "installing leinigen"
    curl -O https://raw.github.com/technomancy/leiningen/stable/bin/lein
    mkdir ~/bin
    mv lein ~/bin
    chmod 755 ~/bin/lein
    lein
fi

#aspell
if type -p aspell; then
    echo "aspell already installed . . . skipping install"
else
    echo "installing aspell"
    brew install aspell --lang=en
fi
