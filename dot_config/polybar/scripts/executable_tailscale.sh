#!/bin/sh
STOPPED="Tailscale is stopped."
STRING=""
if tailscale status | grep -q "$STOPPED"; then
    STRING="%{F#7F848E}󰚊%{F-}"
else
    STRING="%{F#A3BE8C}󰚊%{F-}"
fi
VPN_NAME=$(nmcli --mode tabular --terse connection show --active | grep vpn | cut -d ':' -f1) 
if [[ "${VPN_NAME}" != "" ]];
then
  STRING+=" "
  STRING+="%{F#A3BE8C}%{F-}${VPN_NAME}"
fi
echo $STRING
