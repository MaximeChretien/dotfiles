#!/bin/sh
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# Permissões para Shutdown/Reboot/Suspend com sudo (Void linux):
# sudo visudo
# %wheel ALL=(ALL) NOPASSWD: /usr/bin/halt, /usr/bin/poweroff, /usr/bin/reboot, /usr/bin/shutdown, /usr/bin/zzz, /usr/bin/ZZZ

lock() {
#import -window root /tmp/screenshot.png
#convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
#rm /tmp/screenshot.png
#i3lock -i /tmp/screenshotblur.png
i3lockr -b 25 -- -e
}

case "$1" in
    lock)
        lock
    ;;
    logout)
        i3-msg exit
    ;;
    suspend)
        if [ $(cat /proc/1/comm) = "systemd" ]; then
            systemctl suspend
        elif [ $(cat /proc/1/comm) = "runit" ]; then
            lock && sudo zzz
        else
            lock && dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Suspend boolean:true
        fi
    ;;
    hibernate)
        if [ $(cat /proc/1/comm) = "systemd" ]; then
            systemctl hibernate
        elif [ $(cat /proc/1/comm) = "runit" ]; then
            lock && sudo ZZZ
        else
            lock && dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Hibernate boolean:true
        fi
    ;;
    reboot)
        if [ $(cat /proc/1/comm) = "systemd" ]; then
            systemctl reboot
        elif [ $(cat /proc/1/comm) = "runit" ]; then
            sudo reboot
        else
            dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
        fi
    ;;
    shutdown)
        if [ $(cat /proc/1/comm) = "systemd" ]; then
            systemctl poweroff
        elif [ $(cat /proc/1/comm) = "runit" ]; then
            sudo shutdown -h now
        else
            dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
        fi
    ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
