#!/bin/bash

volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)
icon=""

if [ $volume -le 33 ]
        then
        icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-low-symbolic.svg"
elif [ $volume -ge 66 ]
        then
        icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg"
else
        icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-medium-symbolic.svg"
fi

if [ $mute = "true" ]
        then
        icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"
fi

notify-send --expire-time=300 --icon=$icon -h int:value:$volume -h string:synchronous:volume "Volume"
