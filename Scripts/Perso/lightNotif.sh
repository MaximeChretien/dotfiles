#!/bin/bash

icon='/usr/share/icons/Adwaita/symbolic/status/display-brightness-symbolic.svg'
backlight=$(light -G)

notify-send --expire-time=300 --icon=$icon -h int:value:$backlight -h string:synchronous:backlight "Backlight"
