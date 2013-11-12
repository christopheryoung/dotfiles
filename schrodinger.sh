
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux']]; then
    platform='linux'
elif [[ $unamestr == 'Darwin']]; then
    platform='mac'
fi

 # Paths
export PATH=$PATH:/utils/bin
export PATH=$PATH:/home/young/.local/bin
export SCHRODINGER='/scr/young/schrodinger'
export SCHRODINGER_SRC='/scr/young/schrodinger_src'
export SCHRODINGER_LIB='/software/lib'
export PATH=$PATH:/software/lib/common
export WORKON_HOME=/scr/young
export MAESTRO_SCRIPTS='/home/young/maestro_scripts'

if [[ $(hostname) = "nyc-bld-l02" ]]; then
    export SCHRODINGER='/scr2/young/schrodinger'
    export SCHRODINGER_SRC='/scr2/young/schrodinger_src'
    export CCACHE_DIR='/scr2/young/.ccache'
fi

# Aliases
if [[ $platform == 'linux' ]]; then
    alias emacs='/utils/bin/emacs-24.3'
fi
alias buildinger=$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh
alias pylint='/software/lib/common/pylint-0.28.0/pylint'
alias maestro='$SCHRODINGER/maestro'
alias designer='$SCHRODINGER_LIB/Linux-x86_64/qt-4.6.3/bin/designer'
alias run="$SCHRODINGER/run"

function setvenv() {
    export SCHRODINGER='/scr/young/schrodinger'
    export SCHRODINGER_SRC='/scr/young/schrodinger_src'
    export LD_LIBRARY_PATH='/home/young/.virtualenvs/sch/lib'
    export LDFLAGS='-L/home/young/.virtualenvs/sch/lib'
}

function setaltenv() {
    export SCHRODINGER='/scr/young/alt'
    export SCHRODINGER_SRC='/scr/young/alt_src'
    export LD_LIBRARY_PATH='/home/young/.virtualenvs/alt/lib'
    export LDFLAGS='-L/home/young/.virtualenvs/alt/lib'
}

function mwith() {
    maestro -c $MAESTRO_SCRIPTS/$1
}

# Virtualenv aliases
alias venv='setvenv && source ~/.virtualenvs/sch/bin/activate'
alias venv_alt='setaltenv && source ~/.virtualenvs/alt/bin/activate'
alias venv_13-3='set13_3 && source ~/.virtualenvs/13-3/bin/activate'

if [[ $(hostname) != "nyc-desk-l38" ]]; then
    ngreen=$(tput setaf 2)
    magenta=$(tput setaf 5)
    blue=$(tput setaf 4)
    red=$(tput setaf 1)
    reset=$(tput sgr0)
    bold=$(tput bold)
    PS1='\[$red$bold\]\w\[$reset\]\[$ngreen$bold\]$(__git_ps1 " (%s)")\[$reset\]\$ '
fi

echo "sourced ~/code/dotfiles/schrodinger.sh"
echo "SCHRODINGER: " $SCHRODINGER
echo "SCHRODINGER_SRC: " $SCHRODINGER_SRC
