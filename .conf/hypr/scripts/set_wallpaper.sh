#!/bin/bash

wallpaper_path=/mnt/ntfs/Imágenes/Pictures/16.09/KANOKARI-01.jpg #$HOME/wallpaper/wallpaper.png

if [ ! -f "$wallpaper_path" ]; then
	notify-send -a "swww" "No wallpaper found" "$wallpaper_path"
	exit 1
fi

swww img $wallpaper_path \
	--transition-bezier .43,1.19,1,.4 \
	--transition-fps 60 \
    --transition-step 90 \
	--transition-type "random" \
	--transition-duration 0.7 \
	--invert-y \
	--transition-pos "$(hyprctl cursorpos)"
