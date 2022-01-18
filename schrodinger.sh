#!/bin/bash

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
    echo "Sourcing schrodinger.sh on linux . . . "
elif [[ "$unamestr" == "Darwin" ]]; then
    platform='mac'
    echo "Sourcing schrodinger.sh on a mac"
elif [[ "$unamestr" == "MINGW64_NT-10.0" ]]; then
    platform='win'
    echo "Sourcing schrodinger.sh on windows"
fi

function reportenv() {
    echo "set SCHRODINGER and SCHRODINGER_SRC"
    echo $SCHRODINGER
    echo $SCHRODINGER_SRC
}

# Sneak a yapf fix into the latest commit
function sneak_yapf() {
    yapf -i $1 && git add $1 && git cram
}

y () {
start_dir=$(pwd)
branch=${1:-master}
repo_top_dir=$(git rev-parse --show-toplevel)
cd $repo_top_dir && yapf -i $(git diff --name-only $branch '*.py'); cd $start_dir
}

# Run mmshare tests, pipe output to a file, and then transform it so it can
# serve as an effective compilation buffer in the event there are failures
function mtest() {
    mmake && make unittest TEST_ARGS="$1" 2>&1 | tee ~/test_output.txt && python3 ~/bin/transform_test_output.py ~/test_output.txt $SCHRODINGER_SRC
}


if [[ $platform == 'mac' ]]; then
    code_base='/Users/young/builds'
elif [[ $platform == 'linux' ]]; then
    code_base='/scr2/young'
elif [[ $platform == 'win' ]]; then
    code_base='/home/young/code/builds'
fi


function workon() {
    export SCHRODINGER=$code_base/$1/build
    export SCHRODINGER_SRC=$code_base/$1/source
    reportenv
}

if [[ $(hostname) = "nyc-bld-l02" ]]; then
    export CCACHE_DIR='/scr2/young/.ccache'
fi

# # Common

export PATH=$PATH:/utils/bin
export SCHRODINGER_LIB='/software/lib'
export PATH=$PATH:/software/lib/common
export SCHRODINGER_SHOW_QT_MESSAGES=1

function postr() {
    branch=$(git rev-parse --abbrev-ref HEAD)
    rbt post --bugs-closed=$branch --description "" --summary ""
}

# getv
source ~/code/schnippets/bash/functions/getv.sh

alias buildinger='$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh'
alias ssch='source $SCHRODINGER_SRC/mmshare/build_env'
alias check='ssch && pre-commit run --source @{u} --origin HEAD'
alias maestro='$SCHRODINGER/maestro -console -printenv'
alias run="$SCHRODINGER/run"
alias src='cd $SCHRODINGER_SRC'
alias sch='cd $SCHRODINGER'
alias mm='cd $SCHRODINGER_SRC/mmshare'
alias mae='cd $SCHRODINGER_SRC/maestro-src'
alias mmaestro='mmake && maestro'
alias maelog='less $SCHRODINGER/maestro-v*/make_maestro-src_all.log'
alias mmlog='less $SCHRODINGER/mmshare-v*/make_mmshare_all.log'


if [[ $platform == 'mac' ]]; then
    export MAESTRO_SCRIPTS='/Users/young/code/maestro_scripts'
    export QTDIR="$SCHRODINGER_LIB/Darwin-x86_64/qt-*"
    alias designer='open $QTDIR/bin/Designer.app'
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
