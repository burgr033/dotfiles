dotfiles generated with **[chezmoi](https://github.com/twpayne/chezmoi)**

These are my personal dotfiles.

Configs included:
* Linux
  * zsh
  * alacritty
  * bat
  * dunst
  * i3
  * polybar
  * qutebrowser
  * ranger
  * rofi
  * picom
  * X
* Windows
  * Windows PowerShell
* both
  * Neovim
  * Git

### apply dotfiles (linux)
#### steps
1. get chezmoi
    ```shell
    sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply cigh033
    ```
### apply dotfiles (windows)
#### Steps
1. Install (the best package manager for windows) **[scoop](https://scoop.sh)**
    ```shell
    irm get.scoop.sh | iex
    ```
2. Install Chezmoi through scoop
    ```shell
    scoop install chezmoi
    ```
3. init & apply dotfiles
    ```shell
    chezmoi init https://github.com/cigh033/dotfiles --apply
    ```
