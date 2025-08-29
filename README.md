# dotfiles

## Install

### macOS

```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ cd ~
$ git clone https://github.com/ewnd9/dotfiles.git
$ cd dotfiles
$ ln -s $HOME/dotfiles/config/zshrc $HOME/.zshrc
$ brew install node@16 yarn
$ ./init.sh
```

## Temporary Chrome Extensions

- [Octo Tree](https://chrome.google.com/webstore/detail/octotree/bkhaagjahfmjljalopjnoealnfndnagc?hl=ru)
- [Full Page Screen Capture](https://chrome.google.com/webstore/detail/full-page-screen-capture/fdpohaocaechififmbbbbbknoalclacl)
- [Apollo Client Developer Tools](https://chrome.google.com/webstore/detail/apollo-client-developer-t/jdkknkkbebbapilgoeccciglkfbmbnfm)
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)
- [SurfingKeys](https://github.com/brookhong/Surfingkeys)
- [HabitLab](https://chrome.google.com/webstore/detail/habitlab/obghclocpdgcekcognpkblghkedcpdgd?hl=en)

## Xtra

```sh
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```
