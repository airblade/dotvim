# .vim

I symlink my `~/.vim` directory to this repo.  Similarly for `~/.vimrc` and `~/.gvimrc`.

All addons go in the `bundle` directory and are managed by Pathogen.
Where possible they are installed as git submodules.  For example:

    git submodule add https://github.com/airblade/vim-rooter.git vim/bundle/vim-rooter

After a fresh clone of this repository, get the submodules with:

    git submodule init
    git submodule update

(See [Git Submodules: Adding, Using, Removing, Updating](http://chrisjean.com/2009/04/20/git-submodules-adding-using-removing-and-updating/) for more information.)

If after `call pathogen#helptags()` you get a warning about a dirty submodule,
add `tags` to `bundle/REPO/.git/info/exclude`, where `REPO` is the repository
giving the warning.

Thanks to [John MacFarlane](https://github.com/jgm/dotvim/blob/master/README) for this tip.

## Learn more with PeepCode

If you want to learn more about Vim, I heartily recommend these PeepCode screecasts:

* [Smash Into Vim](http://peepcode.com/products/smash-into-vim-i)
* [Smash Into Vim II](http://peepcode.com/products/smash-into-vim-ii)

But don't take my word for it.  Look at [these Tweets](http://airbladesoftware.com/portfolio) instead.

;)
