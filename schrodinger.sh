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
    if [ $(hostname -s) = "pdx-build-young-lv01" ]; then
	export SCHRODINGER='/home/young/code/schrodinger'
	export SCHRODINGER_SRC='/home/young/code/schrodinger_src'
    elif [[ $platform == 'linux' ]]; then
        export SCHRODINGER='/scr2/young/schrodinger'
        export SCHRODINGER_SRC='/scr2/young/schrodinger_src'
    elif [[ $platform == 'mac' ]]; then
        export SCHRODINGER='/Users/young/code/schrodinger'
        export SCHRODINGER_SRC='/Users/young/code/schrodinger_src'
    fi
    reportenv
}

if [[ $(hostname) = "nyc-bld-l02" ]]; then
    export CCACHE_DIR='/scr2/young/.ccache'
fi

function setaltenv() {
    export SCHRODINGER='/Users/young/code/schrodinger_branch'
    export SCHRODINGER_SRC='/Users/young/code/alt_schrodinger_src'
    reportenv
}

# # Common

setenv

export PATH=$PATH:/utils/bin
export SCHRODINGER_LIB='/software/lib'
export PATH=$PATH:/software/lib/common
export INTEL_LICENSE_FILE=28518@ns4:28518@ns3

function postr() {
    branch=$(git rev-parse --abbrev-ref HEAD)
    rbt post --bugs-closed=$branch --description "" --summary ""
}

alias buildinger=$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh
alias ssch='source $SCHRODINGER_SRC/mmshare/build_env'
alias maestro='$SCHRODINGER/maestro -printenv'
alias run="$SCHRODINGER/run"
alias src='cd $SCHRODINGER_SRC'
alias sch='cd $SCHRODINGER'
alias mm='cd $SCHRODINGER_SRC/mmshare'
alias mae='cd $SCHRODINGER_SRC/maestro-src'
alias mmaestro='mmake && maestro'
alias venv='setenv && source ~/.virtualenvs/sch/bin/activate && export SCHRODINGER_PYTHON_PATH=~/.virtualenvs/sch/bin/python'
alias venv_alt='setaltenv && source ~/.virtualenvs/alt/bin/activate && export SCHRODINGER_PYTHON_PATH=~/.virtualenvs/alt/bin/python'
alias sch_emacs='nohup /Applications/Emacs.app/Contents/MacOS/Emacs "$@" --debug-init &'
alias maelog='less $SCHRODINGER/maestro-v*/make_maestro-src_all.log'
alias mmlog='less $SCHRODINGER/mmshare-v*/make_mmshare_all.log'

if [[ $platform == 'mac' ]]; then
    alias synclib='rm -rf /tmp/schrodinger_lib_sync ; mkdir -p /tmp/schrodinger_lib_sync && cd /tmp/schrodinger_lib_sync && wget -r -np -nd http://cgit/cgit/mmshare/plain/build_tools/schrodinger_lib_sync/ && bash copy_schrodinger_lib.sh -v $SCHRODINGER_LIB NYC Darwin-x86_64 && cd -'
    export MAESTRO_SCRIPTS='/Users/young/code/maestro_scripts'
    alias designer='$SCHRODINGER_LIB/Darwin-x86_64/qt-5.6.2/bin/Designer.app/Contents/MacOS/Designer'
    alias run_msv='mmake && run $SCHRODINGER/mmshare-v*/lib/Darwin-x86_64/lib/python2.7/site-packages/schrodinger/application/msv/gui/msv_gui.py'

elif [[ $platform == 'linux' ]]; then
    export MAESTRO_SCRIPTS='/home/young/maestro_scripts'
    alias emacs='/utils/bin/emacs-24.5'
fi

function mwith() {
    mmake
    echo "Started at " $(date)
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
