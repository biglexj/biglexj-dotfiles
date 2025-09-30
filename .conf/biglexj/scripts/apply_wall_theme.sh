#!/bin/bash
WALLPAPER="$1"

# 1. Cambiar wallpaper con swww
swww img "$WALLPAPER" --transition-type grow --transition-step 90

# 2. Generar colores con wallust
wallust run "$WALLPAPER"

# 3. Recargar Hyprland (para aplicar colores)
hyprctl reload

# 4. Recargar Waybar (para que lea los nuevos colores)
killall waybar && waybar & disown

# 5. Recargar Rofi (si usas su tema con colores)
pkill rofi
