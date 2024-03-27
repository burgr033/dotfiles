#!/bin/sh
STOPPED="Tailscale is stopped."
if tailscale status | grep -q "$STOPPED"; then
    echo "%{F#7F848E}󰚊%{F-}"
else
    echo "%{F#A3BE8C}󰚊%{F-}"
fi

