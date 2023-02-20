#!/bin/sh
if ping -c 1 8.8.8.8 &> /dev/null
    then
        updates=$(checkupdates|wc -l)
    else
        updates=0
fi
if [ "$updates" -gt 0 ]; then
	if [ "$updates" -eq 1 ]; then
		text="update"
	else
		text="updates"
	fi
    echo "%{F#EBCB8B}󰳧%{F-} $updates $text"
else
    echo "%{F#A3BE8C}󱝀%{F-}"
fi
