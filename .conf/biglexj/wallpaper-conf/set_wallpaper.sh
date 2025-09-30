#!/bin/bash
# Usa el symlink dinámico en lugar de una imagen específica
wallpaper_path="$HOME/.config/biglexj/wallpapers/wallpaper.jpg"

# Si no existe el symlink, selecciona uno aleatorio de la carpeta
if [ ! -f "$wallpaper_path" ]; then
    IMAGE_DIR="/mnt/ntfs/Imágenes/Pictures/16.09/"
    if [ -d "$IMAGE_DIR" ]; then
        # Selecciona un wallpaper aleatorio
        random_wallpaper=$(find "$IMAGE_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
        if [ -n "$random_wallpaper" ]; then
            # Crea el directorio si no existe
            mkdir -p "$(dirname "$wallpaper_path")"
            # Crea el symlink
            ln -sf "$random_wallpaper" "$wallpaper_path"
            notify-send -a "swww" "Random wallpaper selected" "$(basename "$random_wallpaper")"
        else
            notify-send -a "swww" "No images found" "$IMAGE_DIR"
            exit 1
        fi
    else
        notify-send -a "swww" "Image directory not found" "$IMAGE_DIR"
        exit 1
    fi
fi

# Aplica el wallpaper usando el symlink
swww img "$wallpaper_path" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps 60 \
    --transition-step 90 \
    --transition-type "random" \
    --transition-duration 0.7 \
    --invert-y \
    --transition-pos "$(hyprctl cursorpos)"
