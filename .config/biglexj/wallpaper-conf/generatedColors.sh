#!/usr/bin/env bash
# genera-colores-walrs.sh
# Uso: ./genera-colores-walrs.sh [imagen] [opciones]
# Si no pasas imagen, usa tu wallpaper por defecto.

set -euo pipefail

DEFAULT="$HOME/.config/biglexj/wallpapers/wallpaper.jpg"
IMG="${1:-$DEFAULT}"
shift || true   # quita el argumento de la imagen si existe para pasar el resto a walrs

if [[ ! -f "$IMG" ]]; then
    echo "❌ No se encuentra la imagen: $IMG"
    exit 1
fi

echo "🎨 Generando esquema con walrs para: $IMG"
# Puedes añadir -b (brillo) o -s (saturación) desde los argumentos restantes
walrs -i "$IMG" "$@"

echo "✅ Colores generados."
echo "Archivos clave:"
echo "  ~/.cache/wal/colors         (archivo de colores plano)"
echo "  ~/.cache/wal/colors.json    (JSON con toda la paleta)"
echo "  ~/.cache/wal/wal            (ruta del wallpaper actual)"
echo
echo "Plantillas: ~/.config/walrs/templates/"
echo "Temas:      ~/.config/wal/colorschemes/"
