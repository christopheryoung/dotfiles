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

## Pinned versions

Every Emacs package is pinned to an exact git commit in
`emacs.d/straight/versions/default.el`, which is tracked in this
repository. It is the equivalent of a lockfile, and it covers more than
the packages named in `custom-packages.el`:

- the 47 declared packages
- their transitive dependencies
- the recipe repositories themselves (melpa, gnu-elpa-mirror and the
  rest), so the package *definitions* are pinned as well, not just the
  packages

A new machine therefore gets exactly these versions rather than whatever
is current. `osx_setup.sh` applies them by running
`emacs.d/bootstrap-packages.el`, which it deliberately runs twice: the
first pass has to resolve recipes from whatever melpa is at when it is
first cloned, and the second reads them from the now-pinned melpa. The
script reports anything straight is using that the lockfile does not
name, which would mean a package is running unpinned.

## Checking the configuration

    emacs --batch -l ~/.emacs.d/check-config.el

Loads the configuration and checks the things that have actually broken
here: bindings pointing at renamed commands, modes that should or should
not be on, packages that have moved to Emacs 31 idioms, and the handful
of settings that once stopped being read without saying so. Exits
non-zero on failure, so it can gate an update.

Batch mode cannot exercise anything needing a window, a command loop or
an idle timer, so those are checked one layer down, at the function the
timer or hook would have called.

## Updating packages

Do not run `straight-pull-all`. Several packages are held at older
releases for Emacs 30 compatibility, and it would move all of them to
HEAD at once -- which is how magit, vertico, consult and jinx each broke.

There is no need to update on a schedule. Nothing here is
security-sensitive, an out-of-date package costs nothing, and updates
have a habit of failing quietly at install time and surfacing days later
in the middle of real work. Update when there is a reason: a bug that
annoys you, a feature you want, or a new Emacs.

When you do, do it where a broken editor is an inconvenience rather than
a disaster -- not first thing on a working morning:

    git commit -am "wip"                       # lockfile is the rollback
    M-x straight-pull-package RET <name> RET   # one, or a few related
    M-x straight-freeze-versions
    emacs --batch -l ~/.emacs.d/check-config.el
    ... then use it for a few days ...

To roll back, `M-x straight-thaw-versions` restores the lockfile, or
`git checkout emacs.d/straight/versions/default.el` first to go back
further.

### Packages held back for Emacs 30

magit, vertico, consult, embark, marginalia and jinx are pinned to
releases that predate their move to Emacs 31 idioms. On Emacs 31 these
holds can be lifted; `check-config.el` reports the running version, and
the bare incf/decf check is what would catch a regression.

## Personal vs work

The personal machine is marked by an empty `~/.personal_machine` file.
Both `.bashrc` and `.emacs` check for it: the work machine sources
`schrodinger.sh`, and the personal machine loads the LLM integration in
`emacs.d/custom/custom-llm.el`. Anything that should not be shared
belongs behind that check, or in `~/.git_private`.
