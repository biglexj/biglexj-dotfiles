#!/bin/bash

sinks=$(pactl list short sinks | awk '{print $2}')
default=$(pactl get-default-sink)

selected=$(echo "$sinks" | rofi -dmenu -p "Salida de audio" -mesg "Actual: $(pactl list sinks short | grep "$default" | awk '{print $2}')")

if [ -n "$selected" ]; then
  pactl set-default-sink "$selected"
  notify-send "Audio" "Salida cambiada a: $selected"
fi
