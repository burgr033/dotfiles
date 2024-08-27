function activate_venv
    set venv_name "venv"

    # Check if the venv exists
    if test -d $venv_name
        echo "Activating existing virtual environment..."
    else
        echo "Creating virtual environment..."
        python3 -m venv $venv_name
    end

    # Activate the virtual environment
    source $venv_name/bin/activate.fish

    # Optional: Install any required packages after activation
    # pip install -r requirements.txt
end
