function p
    set base ~/Projects

    # List project dirs (no hidden, depth 1)
    set projects (find $base -maxdepth 1 -mindepth 1 -type d)

    # Preload search query if provided
    if test (count $argv) -gt 0
        set q $argv[1]
        set selected (printf '%s\n' $projects | fzf \
            --query "$q" \
            --select-1 \
            --exit-0 \
            --reverse \
            --border \
            --height=40% \
            --preview 'tree -L 2 -C {} 2>/dev/null')
    else
        set selected (printf '%s\n' $projects | fzf \
            --reverse \
            --border \
            --height=40% \
            --preview 'tree -L 2 -C {} 2>/dev/null')
    end

    if test -n "$selected"
        cd $selected
    end
end
