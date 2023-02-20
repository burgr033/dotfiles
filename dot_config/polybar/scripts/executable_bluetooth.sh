#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
	#disconnected
	echo "%{F#4C566A}󰂯"
else
	#connected
	OUTPUT="%{F#5E81AC}󰂯"
	while IFS=";" read -r DEVICE_MAC DEVICE_ICON
	do
		if [ $(bluetoothctl info $DEVICE_MAC | grep "Connected: yes" | wc -c) -ne 0 ]
		then
			OUTPUT+="%{F#D8DEE9}"$DEVICE_ICON
		fi
	done < <(cat ~/.config/polybar/scripts/bt_devices.lst)
	echo $OUTPUT
fi

