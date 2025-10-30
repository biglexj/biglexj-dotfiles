#!/bin/bash

image_dir="/mnt/ntfs/Imágenes/Pictures/16.09/" #$HOME/wallpaper
images=("$image_dir"/*)

image_list=""
for img in "${images[@]}"; do
    image_list+=$(basename "$img" | cut -d. -f1)"\x00icon\x1f${img}\n"
done

selected_image=$(printf '%b' "$image_list" | rofi -dmenu -theme ~/.config/rofi/conf/wallpaper-select.rasi -p "Select wallpaper")

for img in "${images[@]}"; do
    if [[ "$(basename "$img" | cut -d. -f1)" = "$selected_image" ]]; then
        selected_image_path="$img"
        break
    fi
done

if [ -n "$selected_image_path" ]; then
  ln -sf "$selected_image_path" ~/.config/biglexj/wallpapers/wallpaper.jpg

  if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    . ~/.config/biglexj/wallpaper-conf/set_wallpaper.sh
  else
    i3-msg restart
  fi

  notify-send -a "Wallpaper selector" "Wallpaper changed" "$selected_image_path" -i ~/.config/biglexj/wallpapers/wallpaper.jpg
  . ~/.config/biglexj/wallpaper-conf/apply_wal_theme.sh
fi

