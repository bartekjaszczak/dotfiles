#!/bin/bash

# Assumptions:
# - wpctl, bc and dunst are installed

msgTag="changeVolume"

wpctl "$@" > /dev/null

# wpctl outputs: "Volume: 1.00 [MUTED]"
volume="$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')" # "1.00"
volume="$(echo "$volume * 100" | bc | cut -d. -f1)" # "100"

isMuted="$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $3}')" # "[MUTED]"

if [[ $volume == 0 || "$isMuted" == "[MUTED]" ]]; then
    dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag -h int:value:"$volume" "Volume: ${volume}% ${isMuted}"
else
    dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag -h int:value:"$volume" "Volume: ${volume}% ${isMuted}"
fi

canberra-gtk-play -i audio-volume-change -d "changeVolume"
