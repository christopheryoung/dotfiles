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

function setschvars() {

    if [[ $platform == 'linux' ]]; then
        export SCHRODINGER='/scr/young/schrodinger'
        export SCHRODINGER_SRC='/scr/young/schrodinger_src'
    elif [[ $platform == 'mac' ]]; then
        export SCHRODINGER='/Users/young/code/schrodinger'
        export SCHRODINGER_SRC='/Users/young/code/schrodinger_src'
    fi
    reportenv
}

function setaltenv() {
    if [[ $platform == 'linux' ]]; then
        export SCHRODINGER='/scr/young/alt'
        export SCHRODINGER_SRC='/scr/young/alt_src'
        export LD_LIBRARY_PATH='/home/young/.virtualenvs/alt/lib'
        export LDFLAGS='-L/home/young/.virtualenvs/alt/lib'

    elif [[ $platform == 'mac' ]]; then
        export SCHRODINGER='/Users/young/code/alt_schrodinger'
        export SCHRODINGER_SRC='/Users/young/code/alt_schrodinger'
        export LD_LIBRARY_PATH='/Users/young/.virtualenvs/alt/lib'
        export LDFLAGS='-L/Users/young/.virtualenvs/alt/lib'
    fi
    reportenv
}

# Common

setschvars

export PATH=$PATH:/utils/bin
export SCHRODINGER_LIB='/software/lib'
export PATH=$PATH:/software/lib/common

alias buildinger=$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh
alias pylint='/software/lib/common/pylint-0.28.0/pylint'
alias maestro='$SCHRODINGER/maestro'
alias run="$SCHRODINGER/run"
alias src='cd $SCHRODINGER_SRC'
alias sch='cd $SCHRODINGER'
alias mm='cd $SCHRODINGER_SRC/mmshare'
alias mmaestro='mmake && maestro'
alias venv='setschvars && source ~/.virtualenvs/sch/bin/activate && export SCHRODINGER_PYTHON_PATH=~/.virtualenvs/sch/bin/python'
alias venv_alt='setaltenv && source ~/.virtualenvs/alt/bin/activate'

if [[ $platform == 'mac' ]]; then
    export MAESTRO_SCRIPTS='/Users/young/code/maestro_scripts'
    export QTDIR=/software/lib/Darwin-x86_64/qt-4.8.5
    export DYLD_FRAMEWORK_PATH=$QTDIR/lib:$DYLD_FRAMEWORK_PATH
    alias designer='open $QTDIR/bin/Designer.app'

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
