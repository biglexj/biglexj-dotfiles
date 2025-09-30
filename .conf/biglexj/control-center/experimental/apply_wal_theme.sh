#!/bin/bash

# Configuración básica
THEME_FILE="/tmp/theme_variant"
WALLPAPER_DIR="/mnt/ntfs/Imágenes/Pictures/16.09/"
wal_arguments=""

# Determinar tema (claro u oscuro)
if [ -s "$THEME_FILE" ]; then
  case $(<"$THEME_FILE") in
    "light") wal_arguments="--lighten -l" ;;
  esac
fi

# Detectar el wallpaper actual usando hyprpaper o swaybg
# Método 1: Intentar obtener de hyprpaper
current_wallpaper=""

if command -v hyprctl &> /dev/null; then
    # Para Hyprland con hyprpaper
    current_wallpaper=$(hyprctl -j getoption general:background | jq -r '.str' | cut -d' ' -f1)
elif command -v swaymsg &> /dev/null; then
    # Para Sway
    current_wallpaper=$(swaymsg -t get_outputs -r | jq -r '.[0].current_workspace | .output')
fi

# Si no se pudo detectar, usar el más reciente del directorio
if [ -z "$current_wallpaper" ] || [ ! -f "$current_wallpaper" ]; then
    current_wallpaper=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) -print0 | xargs -0 ls -t | head -n 1)
fi

# Aplicar pywal con el wallpaper detectado
wal -i "$current_wallpaper" --cols16 $wal_arguments -q -n -e

# Configurar kitty
kitty_conf="$HOME/.config/kitty/kitty.conf"
include_line="include ~/.cache/wal/colors-kitty.conf"
mkdir -p "$(dirname "$kitty_conf")"
if [ ! -f "$kitty_conf" ]; then
    echo "$include_line" > "$kitty_conf"
elif ! grep -q "include.*colors-kitty\.conf" "$kitty_conf"; then
    echo "$include_line" >> "$kitty_conf"
fi

# Recargar kitty si está ejecutándose
if pgrep -x "kitty" > /dev/null; then
    killall -USR1 kitty
fi

# Actualizar swaync
swaync-client -rs

# Actualizar pywalfox si está instalado
if command -v pywalfox &> /dev/null; then
    pywalfox update
fi

# Notificar al usuario
notify-send -a "pywal16" "Tema actualizado" "Se han aplicado nuevos colores basados en el fondo actual" -i "$current_wallpaper"