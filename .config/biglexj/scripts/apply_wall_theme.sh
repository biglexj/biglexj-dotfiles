#!/bin/bash
WALLPAPER="$1"

# Detectar si usar swww o awww
if command -v swww &>/dev/null; then
    WALL_CMD="swww"
elif command -v awww &>/dev/null; then
    WALL_CMD="awww"
else
    notify-send -a "Wallpaper" "Error" "Ni swww ni awww están instalados"
    exit 1
fi

# 1. Cambiar wallpaper con swww/awww
$WALL_CMD img "$WALLPAPER" --transition-type grow --transition-step 90

# 2. Generar colores con wallust
wallust run "$WALLPAPER"

# 3. Recargar Hyprland (para aplicar colores)
hyprctl reload

# 4. Recargar Waybar (para que lea los nuevos colores)
killall waybar && waybar & disown

# 5. Recargar Rofi (si usas su tema con colores)
pkill rofi
