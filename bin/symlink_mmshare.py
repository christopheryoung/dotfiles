#!/usr/bin/python
import os
import sys
import filecmp


MMSHARE_MODULES_TARGET='/scr/young/schrodinger/mmshare-v2.5/lib/Linux-x86_64/lib/python2.7/site-packages/schrodinger'
MMSHARE_MODULES_REPO='/scr/young/schrodinger_src/mmshare/python/modules/schrodinger'


def walker(dirname, ext):
    for (root, dirs, files) in os.walk(dirname):
        for f in files:
            if os.path.splitext(f)[-1] == ext:
                full_path = os.path.join(root, f)
                yield full_path.replace(dirname, "")


def nice_join(root, partial_path):
    if partial_path.startswith("/"):
        partial_path = partial_path[1:]
    return os.path.join(root, partial_path)


def get_sibling(repo, partial_path):
    file_in_repo = nice_join(repo, partial_path)
    if os.path.exists(file_in_repo):
        return file_in_repo


def symlink_mmshare_modules():
    count = 0
    not_symlinked = []
    for f in walker(MMSHARE_MODULES_TARGET, '.py'):
        sibling = get_sibling(MMSHARE_MODULES_REPO, f)
        if sibling:
            full_f = nice_join(MMSHARE_MODULES_TARGET, f)
            if filecmp.cmp(full_f, sibling):
                os.remove(full_f)
                os.symlink(sibling, full_f)
                count += 1
                sys.stdout.write(".")
                sys.stdout.flush()
            else:
                not_symlinked.append(full_f)

    print "\n"
    print "Symlinking Complete"
    if not_symlinked:
        print "Not symlinked: ", ", ".join(not_symlinked)
    print "\n"


if __name__=='__main__':
    symlink_mmshare_modules()
        
