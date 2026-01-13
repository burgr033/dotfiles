# my personal dotfiles

dotfiles generated with **[chezmoi](https://github.com/twpayne/chezmoi)**

Configs include:

- Linux
  - hyprland
  - foot
  - fish
  - eza
  - zellij
- Windows
  - Windows PowerShell
  - Windows Terminal
- both
  - git
  - starship
  - bat
  - lazygit
  - neovim

## applying my dotfiles

> [!WARNING]
> If you install these dotfiles with chezmoi, and during setup you get asked if
> you want to setup manually, and you answer "no" a bunch of stuff will be installed
> (see .chezmoiscripts)

### steps (arch)

1. get chezmoi

   ```shell
   sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply burgr033
   ```

### Steps (windows)

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
