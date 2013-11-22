#!/bin/bash

# First make install mmshare and then set up the appropriate symlinks
cd $SCHRODINGER/mmshare-v*/python/scripts
make install
cd $SCHRODINGER/mmshare-v*/python/modules
make schrodinger_modules
python ~/bin/symlink_mmshare.py
