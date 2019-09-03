
# Mac

```console
$ mkdir ~/go/src/github.com/kazukousen/
$ cd ~/go/src/github.com/kazukousen/
$ git clone https://github.com/kazukousen/dotfiles.git
$ cd dotfiles
```

## Homebrew

```console
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## tmux

```console
$ brew install tmux
$ brew install reattach-to-user-namespace
$ cp _mac_tmux.conf ~/.tmux.conf
```

## Hammerspoon

Download https://www.hammerspoon.org

```console
$ cp init.lua ~/.hammerspoon/init.lua
```

## VSCode

https://code.visualstudio.com/

```console
$ mkdir -p ~/Library/Application\ Support/Code/User/
$ cp setting.json ~/Library/Application\ Support/Code/User/setting.json
```

## tig

```console
$ brew install tig
```

## Vim

```console
$ cp _vimrc ~/.vimrc
```
