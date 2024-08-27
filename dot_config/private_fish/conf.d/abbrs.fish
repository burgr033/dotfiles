if not set -q fish_initialized
    abbr -a -- g git
    abbr -a -- mkdir 'mkdir -p -v'
    abbr -a -- mv 'mv -i'
    abbr -a -- tree 'tree -dirsfirst -F'

    
    abbr -a -- grep rg

    abbr -a -- find fd

    abbr -a -- ls exa
    abbr -a -- ll 'exa --long --all --group --git'
    abbr -a -- lt 'exa --long --all --group --header --tree --level'

    # utilities
    abbr --add -- activate '. venv/bin/activate.fish'
    abbr --add -- cdgr 'cd (git root)'
    abbr --add -- ip-addr 'curl api.ipify.org'
    abbr --add -- isodate 'date +%Y-%m-%d'
    abbr --add -- isodatetime 'date +"%Y-%m-%dT%H:%M:%S"'
    abbr --add -- pip-purge 'pip freeze --exclude-editable | xargs pip uninstall -y'
    abbr --add -- unset 'set --erase'

    set -U fish_initialized
end
