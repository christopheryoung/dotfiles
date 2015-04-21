#!/bin/bash

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
    echo "Sourcing schrodinger.sh on linux . . . "
elif [[ "$unamestr" == "Darwin" ]]; then
    platform='mac'
    echo "Sourcing schrodinger.sh on a mac"
fi

function reportenv() {
    echo "set SCHRODINGER and SCHRODINGER_SRC"
    echo $SCHRODINGER
    echo $SCHRODINGER_SRC
}

function setenv() {

    if [[ $platform == 'linux' ]]; then
        export SCHRODINGER='/scr2/young/schrodinger'
        export SCHRODINGER_SRC='/scr2/young/schrodinger_src'
    elif [[ $platform == 'mac' ]]; then
        export SCHRODINGER='/Users/young/code/schrodinger'
        export SCHRODINGER_SRC='/Users/young/code/schrodinger_src'
    fi
    reportenv
}

function setaltenv() {
    export SCHRODINGER='/Users/young/code/schrodinger_branch'
    export SCHRODINGER_SRC='/Users/young/code/schrodinger_src'
    reportenv
}

# # Common

setenv

export PATH=$PATH:/utils/bin
export SCHRODINGER_LIB='/software/lib'
export PATH=$PATH:/software/lib/common

function postr() {
    branch=$(git rev-parse --abbrev-ref HEAD)
    rbt post --bugs-closed=$branch --target-people=toh --description=""
}

alias buildinger=$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh
alias pylint='/software/lib/common/pylint-0.28.0/pylint'
alias maestro='$SCHRODINGER/maestro'
alias run="$SCHRODINGER/run"
alias src='cd $SCHRODINGER_SRC'
alias sch='cd $SCHRODINGER'
alias mm='cd $SCHRODINGER_SRC/mmshare'
alias maesrc='cd $SCHRODINGER_SRC/maestro-src'
alias mmaestro='mmake && maestro'
alias venv='setenv && source ~/.virtualenvs/sch/bin/activate && export SCHRODINGER_PYTHON_PATH=~/.virtualenvs/sch/bin/python'
alias venv_alt='setaltenv && source ~/.virtualenvs/alt/bin/activate && export SCHRODINGER_PYTHON_PATH=~/.virtualenvs/alt/bin/python'
alias pep8_commit='git commit --author="autopep8 <christopher.young@schrodinger.com>" -m'
alias sch_emacs='nohup /Applications/Emacs.app/Contents/MacOS/Emacs "$@" --debug-init &'

if [[ $platform == 'mac' ]]; then
    export MAESTRO_SCRIPTS='/Users/young/code/maestro_scripts'
    export QTDIR=/software/lib/Darwin-x86_64/qt-4.8.5
    export DYLD_FRAMEWORK_PATH=$QTDIR/lib:$DYLD_FRAMEWORK_PATH
    alias designer='open $QTDIR/bin/Designer.app'
    alias run_msv='mmake && run $SCHRODINGER/mmshare-v*/lib/Darwin-x86_64/lib/python2.7/site-packages/schrodinger/application/msv/gui/msv_gui.py'
    
elif [[ $platform == 'linux' ]]; then
    export MAESTRO_SCRIPTS='/home/young/maestro_scripts'
    alias emacs='/utils/bin/emacs-24.3'
    alias designer='$SCHRODINGER_LIB/Linux-x86_64/qt-4.6.3/bin/designer'
fi

if [[ $(hostname) = "nyc-bld-l02" ]]; then
    export SCHRODINGER='/scr2/young/schrodinger'
    export SCHRODINGER_SRC='/scr2/young/schrodinger_src'
    export CCACHE_DIR='/scr2/young/.ccache'
fi

function mwith() {
    mmake
    maestro -c $MAESTRO_SCRIPTS/$1
}


if [[ $(hostname) == "nyc-bld-l02" ]]; then
    ngreen=$(tput setaf 2)
    magenta=$(tput setaf 5)
    blue=$(tput setaf 4)
    red=$(tput setaf 1)
    reset=$(tput sgr0)
    bold=$(tput bold)
    PS1='\[$red$bold\]\w\[$reset\]\[$ngreen$bold\]$(__git_ps1 " (%s)")\[$reset\]\$ '
fi

echo "sourced $HOME/code/dotfiles/schrodinger.sh"
