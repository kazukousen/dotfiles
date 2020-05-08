
# Mac

- Alfred https://www.alfredapp.com
- Chrome https://www.google.co.jp/chrome/
- Slack https://slack.com/intl/ja-jp/downloads/mac
- DropBox https://www.dropbox.com/ja/install
- VSCode https://code.visualstudio.com
- Docker https://hub.docker.com/editions/community/docker-ce-desktop-mac
- GoLand https://www.jetbrains.com/go/
- Intellij IDEA https://www.jetbrains.com/idea/download/#section=mac

```console
$ mkdir -p ~/go/src/github.com/kazukousen/
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

## Google Cloud SDK

```console
$ tar -xzvf ~/Downloads/google-cloud-sdk-* -C ~/
$ cd ~
$ ./google-cloud-sdk/install.sh
$ source ~/.bash_profile
$ gcloud init
```

## Goland And Intellij IDEA

```console
$ cp .ideavimrc ~/.ideavimrc
```
