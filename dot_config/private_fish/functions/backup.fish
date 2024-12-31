
function backup --argument filename --description 'Backup file or directory'
    if test -f $filename
        set backup_file "$filename.bak"
        if test -e $backup_file
            echo "Error: Backup file '$backup_file' already exists."
            return 1
        end
        cp $filename $backup_file
        echo "File '$filename' has been backed up as '$backup_file'"
    else if test -d $filename
        set backup_dir "$filename.bck"
        if test -e $backup_dir
            echo "Error: Backup directory '$backup_dir' already exists."
            return 1
        end
        cp -r $filename $backup_dir
        echo "Directory '$filename' has been copied as '$backup_dir'"
    else
        echo "Error: '$filename' is neither a file nor a directory."
        return 1
    end
end

function restore --argument filename --description 'Restore file or directory from backup'
    if string match -q "*.bak" $filename
        set original_name (string replace ".bak" "" $filename)
        if test -e $original_name
            echo "Error: Original file '$original_name' already exists."
            return 1
        end
        mv $filename $original_name
        echo "Backup file '$filename' has been restored to '$original_name'"
    else if string match -q "*.bck" $filename
        set original_dir (string replace ".bck" "" $filename)
        if test -e $original_dir
            echo "Error: Original directory '$original_dir' already exists."
            return 1
        end
        mv $filename $original_dir
        echo "Backup directory '$filename' has been restored to '$original_dir'"
    else
        echo "Error: '$filename' is not a recognized backup format (.bak or .bck)."
        return 1
    end
end
