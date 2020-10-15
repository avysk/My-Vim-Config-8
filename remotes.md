# Remotes for git subtrees in `pack\_git_trees\start`

- [drawit](https://github.com/vim-scripts/DrawIt) didn't change since 2013, so no remote
- [tslime](https://github.com/jimmyharris/tslime.vim) didn't change sine 2010,
  so no remote

```
[remote "ale"]
        url = https://github.com/dense-analysis/ale.git
        fetch = +refs/heads/*:refs/remotes/ale/*
[remote "fzf"]
        url = https://github.com/junegunn/fzf.git
        fetch = +refs/heads/*:refs/remotes/fzf/*
[remote "fzf.vim"]
        url = https://github.com/junegunn/fzf.vim.git
        fetch = +refs/heads/*:refs/remotes/fzf.vim/*
[remote "vim-graphql"]
        url = https://github.com/jparise/vim-graphql.git
        fetch = +refs/heads/*:refs/remotes/vim-graphql/*
[remote "vim-tagbar"]
        url = https://github.com/preservim/tagbar.git
        fetch = +refs/heads/*:refs/remotes/vim-tagbar/*
```
