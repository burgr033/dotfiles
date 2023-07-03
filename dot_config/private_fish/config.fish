if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (zellij setup --generate-auto-start fish | string collect)
    alias vi="nvim"
    alias vim="nvim"
    alias cat="bat --plain"
    fish_add_path $HOME/.local/bin
    set EDITOR "nvim"
    set VISUAL "nvim"
end
