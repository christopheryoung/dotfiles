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

    Brewfile                packages for any machine
    Brewfile.personal       heavier research stack; personal machines only
    setup.sh                creates the symlinks; safe to re-run
    osx_setup.sh            first-run setup for a Mac; safe to re-run
    schrodinger.sh          work-machine shell extras
    bin/                    small scripts

## Setting up a machine

Install Emacs first, from https://emacsformacosx.com, then:

    ./setup.sh                  # symlinks; safe to re-run
    touch ~/.personal_machine   # personal machines only, see below
    ./osx_setup.sh --dry-run    # see what it would do
    ./osx_setup.sh              # Homebrew, packages, Emacs packages

Both scripts are idempotent. `osx_setup.sh --with-locate` additionally
enables the locate database, which needs sudo and touches a system
daemon, so it is off by default.

`osx_setup.sh` installs the Emacs packages by running
`emacs.d/bootstrap-packages.el`, which clones them and then checks each
one out at the commit recorded in `emacs.d/straight/versions/default.el`.
That order matters: straight.el otherwise clones each package's default
branch, and several of those now require Emacs 31 -- magit's HEAD calls
`incf` unprefixed, so a normal first start would fail before you could
reach `M-x straight-thaw-versions`.

The Python tree-sitter grammar is compiled on demand; if
`python-ts-mode` is not being used, run `M-x
treesit-install-language-grammar` and choose python.

## Updating packages

Do not run `straight-pull-all`. Several packages are held at older
releases for Emacs 30 compatibility, and it would move all of them to
HEAD. Update one at a time:

    M-x straight-pull-package RET <name> RET
    ... use it, confirm it still works ...
    M-x straight-freeze-versions

`M-x straight-thaw-versions` restores everything to the lockfile.

## Personal vs work

The personal machine is marked by an empty `~/.personal_machine` file.
Both `.bashrc` and `.emacs` check for it: the work machine sources
`schrodinger.sh`, and the personal machine loads the LLM integration in
`emacs.d/custom/custom-llm.el`. Anything that should not be shared
belongs behind that check, or in `~/.git_private`.
