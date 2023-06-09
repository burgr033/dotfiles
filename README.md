**dotfiles generated with [chezmoi](https://github.com/twpayne/chezmoi)**
### info
+ **OS**: [Manjaro](https://manjaro.org/) (or headless ubuntu server)
+ **WM**: [i3-gaps](https://github.com/Airblader/i3)
+ **Lock Screen**: [i3lock](https://github.com/i3/i3lock)
+ **Wallpaper**: [@dxnst nord backgrounds](https://github.com/dxnst/nord-backgrounds/)
+ **Font**: Fira Code
+ **Shell**: [zsh with oh-my-zsh and bira theme](https://github.com/robbyrussell/oh-my-zsh)
+ **Bar**: [Polybar](https://github.com/jaagr/polybar)
+ **Editor**: [Neovim with AstroNvim config](https://github.com/AstroNvim/AstroNvim)
+ + **EditorConfig**: [nvim-config](https://github.com/cigh033/nvim-config)
+ **Greeter**: [ly](https://github.com/fairyglade/ly)
+ **Dotfiles**: [DotFiles](https://github.com/cigh033/dotfiles)

### apply dotfiles
```shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply cigh033
```
