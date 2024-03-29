dotfiles generated with **[chezmoi](https://github.com/twpayne/chezmoi)**

These are my personal dotfiles.

Configs included:
* Linux
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
  * Windows Terminal
  * GlazeWM
* both
  * Neovim
  * Git

### apply dotfiles (linux)
#### steps
1. get chezmoi
    ```shell
    sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply burgr033
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
    chezmoi init burgr033 --apply
    ```
