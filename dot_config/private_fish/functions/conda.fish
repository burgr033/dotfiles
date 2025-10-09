function conda
    echo "Lazy loading conda upon first invocation..."
    functions --erase conda
    for conda_path in $CONDA_PATH
        if test -f $conda_path
            echo "Using Conda installation found in $conda_path"
            eval $conda_path "shell.fish" "hook" | source
            conda $argv
            return
        end
    end
    echo "No conda installation found in $CONDA_PATH"
end
