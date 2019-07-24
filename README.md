Grignaak's dotfiles

These are managed by stow or stowsh

```
brew install stow

cd ~/dotfiles
find . -type d -mindepth 1 -maxdepth 1| sed "s|^\./||" | xargs -I% stow %
```
