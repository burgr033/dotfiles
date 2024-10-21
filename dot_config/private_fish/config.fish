set fish_greeting
if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.go/bin
    alias vi="nvim"
    alias vim="nvim"
    alias apophis="virtualboxvm --startvm Apophis"
    alias cat="bat --plain"
    alias scratch="nvim -c Scratch"
    set --export GPG_TTY $(tty)
    set --export SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    
    set --export EDITOR "nvim"
    set --export GOPATH "$HOME/.go"
    set --export VISUAL "nvim"
    
    if not set -q DISPLAY
        if not set -q ZELLIJ                                                                                                                                                           
            if test "$ZELLIJ_AUTO_ATTACH" = "true"                                                                                                                                     
                zellij attach -c                                                                                                                                                       
            else                                                                                                                                                                       
                zellij                                                                                                                                                                 
            end                                                                                                                                                                        
            if test "$ZELLIJ_AUTO_EXIT" = "true"                                                                                                                                       
                kill $fish_pid                                                                                                                                                         
            end                                                                                                                                                                        
        end
    end
end
starship init fish | source
