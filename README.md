This is the contents of my .vim directory.

All addons go in the `bundle` directory and are managed by Pathogen.
Where possible they are installed as git submodules.  For example:

    git submodule add https://github.com/airblade/vim-rooter.git vim/bundle/vim-rooter

After a fresh clone of this repository, get the submodules with:

    git submodule init
    git submodule update

If after `call pathogen#helptags()` you get a warning about a dirty submodule,
add `tags` to `bundle/REPO/.git/info/exclude`, where `REPO` is the repository
giving the warning.

Thanks to [John MacFarlane](https://github.com/jgm/dotvim/blob/master/README) for this tip.
