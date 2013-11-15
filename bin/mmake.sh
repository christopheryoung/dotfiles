#!bin/bash

# First make install mmshare and then set up the appropriate symlinks
cd $SCHRODINGER/mmshare-v*/python/scripts
make install
python ~/bin/symlink_mmshare.py
