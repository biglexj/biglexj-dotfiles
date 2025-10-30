#!/bin/bash

WALLPAPER_PATH="${1:-$HOME/.config/biglexj/wallpapers/wallpaper.jpg}"
THEME_FILE="/tmp/theme_variant"

# Argumentos para walrs
walrs_arguments=""
if [ -s "$THEME_FILE" ]; then
    case $(<"$THEME_FILE") in
        "light") walrs_arguments="--light" ;;
        "dark") walrs_arguments="--dark" ;;
    esac
fi

# Verificar que el wallpaper existe
if [ ! -f "$WALLPAPER_PATH" ]; then
    notify-send -a "Theme Manager" "Error" "Wallpaper not found: $WALLPAPER_PATH"
    exit 1
fi

# Aplicar walrs (reemplaza a wal)
echo "Generating color scheme with walrs..."
walrs -i "$WALLPAPER_PATH" $walrs_arguments

# Recargar waybar
if pgrep -x "waybar" >/dev/null; then
    echo "Reloading waybar..."
    killall waybar
    sleep 0.5
fi
waybar &

# Recargar SwayNC
if pgrep -x "swaync" >/dev/null; then
    echo "Reloading SwayNC..."
    swaync-client -rs
fi

# Actualizar pywalfox si está disponible
if command -v pywalfox >/dev/null 2>&1; then
    echo "Updating pywalfox..."
    pywalfox update
fi

echo "Theme applied successfully!"
