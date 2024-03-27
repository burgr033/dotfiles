#!/bin/bash

# Function to check the current orientation using xrandr
get_orientation() {
    xrandr --verbose | grep " connected" | awk '{print $6}'
}

# Function to rotate the screen to the left
rotate_left() {
    xrandr --output "$(xrandr --verbose | grep " connected" | awk '{print $1}')" --rotate left
    xinput --map-to-output 'Wacom HID 52EB Pen Eraser (0x82a1fc67)' eDP
    xinput --map-to-output 'Wacom HID 52EB Finger' eDP
    xinput --map-to-output 'Wacom HID 52EB Pen Pen (0x82a1fc67)' eDP
}

# Function to rotate the screen to normal orientation
rotate_normal() {
    xrandr --output "$(xrandr --verbose | grep " connected" | awk '{print $1}')" --rotate normal
    xinput --map-to-output 'Wacom HID 52EB Pen Eraser (0x82a1fc67)' eDP
    xinput --map-to-output 'Wacom HID 52EB Finger' eDP
    xinput --map-to-output 'Wacom HID 52EB Pen Pen (0x82a1fc67)' eDP
}

# Check if parameter is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <parameter>"
    exit 1
fi

# Read parameter
param="$1"

# Case statement to determine action based on parameter
case "$param" in
    a)
        custom_pmenu
        ;;
    b)
        current_orientation=$(get_orientation)
        if [ "$current_orientation" == "normal" ]; then
            rotate_left
        elif [ "$current_orientation" == "left" ]; then
            rotate_normal
        else
            echo "Unknown orientation: $current_orientation"
            exit 1
        fi
        ;;
    *)
        echo "Invalid parameter '$param'. Please provide 'a' or 'b'."
        exit 1
        ;;
esac
