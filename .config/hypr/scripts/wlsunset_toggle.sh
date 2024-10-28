#!/usr/bin/bash

if pidof wlsunset > /dev/null; then
    pkill wlsunset
    notify-send "wlsunset" "Disabled" -r 1001
else
    wlsunset -t 3500 -T 6700 -l 51.8 -L 19.4 -g 0.8 &
    notify-send "wlsunset" "Enabled" -r 1001
fi
