function _fzf_view_projects
    set -q PROJECTS_DIR; or set PROJECTS_DIR ~/Projects
    set -q PROJECTS_AUTO_OPEN_EDITOR; or set PROJECTS_AUTO_OPEN_EDITOR true
    set fzf_opts \
        --height=40% \
        --layout=reverse \
        --border \
        --preview="tree -L 1 {}" \
        --preview-window=right:40% \
        
    if type -q fd
        set repos (fd -t d -H '^\.git$' $PROJECTS_DIR -x dirname | sort -u | fzf --prompt="Project: " $fzf_opts)
    else
        set repos (find $PROJECTS_DIR -name ".git" -type d -prune -printf '%h\n' | sort -u | fzf --prompt="Project: " $fzf_opts)
    end

    if test -n "$repos"
        cd "$repos"
        commandline -f repaint 
        if test "$PROJECTS_AUTO_OPEN_EDITOR" = "true"
            eval "$EDITOR ."
        end

    end
end

