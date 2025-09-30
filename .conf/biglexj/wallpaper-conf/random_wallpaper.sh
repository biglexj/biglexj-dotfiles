#!/bin/bash

IMAGE_DIR="/mnt/ntfs/Imágenes/Pictures/16.09/"
CURRENT_IMAGE="$HOME/.config/biglexj/wallpapers/wallpaper.jpg"
APP_NAME="Wallpaper selector"
SET_WALLPAPER_SCRIPT="$HOME/.config/biglexj/wallpaper-conf/set_wallpaper.sh"
APPLY_WAL_THEME_SCRIPT="$HOME/.config/biglexj/wallpaper-conf/apply_wal_theme.sh"

validate_image_directory() {
    if [ ! -d "$IMAGE_DIR" ]; then
        notify-send -a "$APP_NAME" "Image directory does not exist" "$IMAGE_DIR"
        exit 1
    fi
}

select_random_image() {
	local random_image="${images[RANDOM % ${#images[@]}]}"
	if [ ! -f "$CURRENT_IMAGE" ]; then
		echo "$random_image"
	else
		local selected_image
		while :; do
			selected_image="$random_image"
			[ "$selected_image" -ef "$CURRENT_IMAGE" ] || break
		done
		echo "$selected_image"
	fi
}

set_new_wallpaper() {
	ln -sf "$1" "$CURRENT_IMAGE"
}

restart_environment() {
	if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
		. "$SET_WALLPAPER_SCRIPT"
	else
		i3-msg restart
	fi
}

send_notification() {
  notify-send -a "$APP_NAME" "Wallpaper changed" "$random_image" -i "$CURRENT_IMAGE"
}

apply_wal_theme() {
  . "$APPLY_WAL_THEME_SCRIPT"
}

validate_image_directory
images=("$IMAGE_DIR"/*)
validate_images "${#images[@]}"
random_image=$(select_random_image)
set_new_wallpaper "$random_image"
restart_environment
send_notification
apply_wal_theme
