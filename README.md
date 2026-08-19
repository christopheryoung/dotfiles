# dotfiles

Configuration shared between my personal Mac and my work machine.

## Layout

    .bashrc .bash_profile   shell; must stay bash 3.2 compatible and must
    .aliases .functions     not assume macOS, since both machines use it
    .inputrc .tmux.conf
    .vimrc .vim/

    .emacs emacs.d/         Emacs 30. Packages via straight.el, pinned by
                            emacs.d/straight/versions/default.el

    gitconfig gitignore     linked to ~/.gitconfig and ~/.gitignore;
                            private settings live in ~/.git_private,
                            pulled in with [include]

    Brewfile                packages for a new Mac
    setup.sh                creates the symlinks; safe to re-run
    osx_setup.sh            first-run setup for a new Mac
    schrodinger.sh          work-machine shell extras
    bin/                    small scripts

## Setting up a machine

    ./setup.sh
    ./osx_setup.sh          # macOS only, installs Homebrew and packages

## Personal vs work

The personal machine is marked by an empty `~/.personal_machine` file.
Both `.bashrc` and `.emacs` check for it: the work machine sources
`schrodinger.sh`, and the personal machine loads the LLM integration in
`emacs.d/custom/custom-llm.el`. Anything that should not be shared
belongs behind that check, or in `~/.git_private`.
