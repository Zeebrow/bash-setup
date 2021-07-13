# Memory aid for commands, e.g. that require a lot of specific options.

## python packaging

### devpi

Init a new user and index
```
devpi login XYZ
devpi user -c new_user
```

Create a new package index at, for example, `https://pip.mzborowski.com/new_user/new_index`
```
devpi login new_user
devpi index -c new_index
```

### build twine

Make required files

- setup.py
- pyproject.toml

```
python3 -m build
twine upload --verbose --config-file /home/zeebrow/.pypirc \
--repository-url https://pip.mzborowski.com/zeebrow/c --username \
new_user dist/*
```

##TODO

### vim

1. ~/.vim/autoload/plug.vim
2. vim-pandoc/vim-pandoc
    - rwxbob/vim-pandoc-style
