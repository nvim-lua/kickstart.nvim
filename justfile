cleanup:
    rm -rf ~/.local/state/nvim
    rm -rf ~/.local/share/nvim

merge:
    # git remote add upstream git@github.com:nvim-lua/kickstart.nvim.git
    git checkout master
    git fetch upstream
    git merge upstream/master
    # is there a conflict?
