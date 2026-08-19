#!/bin/bash
################################################################################
# Sets up my environment, including dot files.
#
# Safe to re-run: every link is replaced in place, and nothing is deleted
# that this script did not create.
################################################################################

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$DOTFILES/$1" dest="$2"
    if [ ! -e "$src" ]; then
        echo "  skip $dest (no $src)"
        return
    fi
    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
    echo "  $dest -> $src"
}

########################################
# Dotfiles
########################################

echo "Linking dotfiles into $HOME"

for f in bashrc bash_profile aliases functions inputrc tmux.conf vimrc emacs; do
    link ".$f" "$HOME/.$f"
done

link ".vim"    "$HOME/.vim"
link "emacs.d" "$HOME/.emacs.d"

# gitconfig is a symlink like everything else; anything private or
# machine-specific goes in ~/.git_private, which gitconfig pulls in with
# an [include] directive. It used to be *copied* here with ~/.git_private
# concatenated onto it, which meant edits to this repo never reached
# ~/.gitconfig at all.
link "gitconfig" "$HOME/.gitconfig"
link "gitignore" "$HOME/.gitignore"

if [ ! -f "$HOME/.git_private" ]; then
    cat > "$HOME/.git_private" <<'PRIVATE'
# Machine-local git settings. Not tracked in the dotfiles repo.
# [user]
#     email = you@example.com
PRIVATE
    echo "  created $HOME/.git_private"
fi

########################################
# Machine type
########################################

# The work machine is the one *without* this marker; .bashrc and .emacs
# both key off it.
if [ ! -f "$HOME/.personal_machine" ]; then
    echo
    echo "Note: $HOME/.personal_machine does not exist, so this is treated"
    echo "as a work machine. Run 'touch ~/.personal_machine' if that is wrong."
fi

echo
echo "Done. Run ./osx_setup.sh on a new Mac to install packages."
