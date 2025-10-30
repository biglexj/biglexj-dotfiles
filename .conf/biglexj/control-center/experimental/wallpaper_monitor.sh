#!/bin/bash

# wallpaper_monitor.sh - Monitorea cambios en el fondo de pantalla y aplica pywal16

# Configuración
WALLPAPER_PATH="/mnt/ntfs/Imágenes/Pictures/16.09/KANOKARI-01.jpg" # Ruta del fondo actual
THEME_FILE="/tmp/theme_variant"
APP_NAME="Wallpaper Monitor"
LAST_MODIFIED_FILE="/tmp/last_wallpaper_modified"
CHECK_INTERVAL=2 # segundos entre verificaciones

# Verifica que pywal esté instalado
if ! command -v wal &> /dev/null; then
    notify-send -a "$APP_NAME" "Error" "pywal no está instalado. Por favor instálalo con 'pip install pywal'"
    exit 1
fi

# Función para aplicar el tema pywal
apply_wal_theme() {
    # Determinar si usar el tema claro u oscuro
    wal_arguments=""
    if [ -s "$THEME_FILE" ]; then
        case $(<"$THEME_FILE") in
            "light") wal_arguments="--lighten -l" ;;
        esac
    fi
    
    # Aplicar pywal16
    wal -i "$WALLPAPER_PATH" --cols16 $wal_arguments -q -n -e
    
    # Reiniciar waybar si está en ejecución
    if pgrep -x "waybar" >/dev/null; then
        killall waybar
        waybar &
    fi
    
    # Actualizar otras aplicaciones
    swaync-client -rs
    pywalfox update
    
    # Enviar notificación
    notify-send -a "$APP_NAME" "Tema actualizado" "Se han aplicado nuevos colores basados en el fondo" -i "$WALLPAPER_PATH"
}

# Función para verificar cambios en el fondo de pantalla
check_wallpaper_changes() {
    if [ ! -f "$WALLPAPER_PATH" ]; then
        notify-send -a "$APP_NAME" "Error" "No se encuentra el fondo en: $WALLPAPER_PATH"
        return 1
    fi
    
    # Obtener la última modificación del archivo
    current_modified=$(stat -c %Y "$WALLPAPER_PATH")
    
    # Comprobar si ha cambiado desde la última verificación
    if [ ! -f "$LAST_MODIFIED_FILE" ] || [ "$current_modified" != "$(cat "$LAST_MODIFIED_FILE")" ]; then
        echo "$current_modified" > "$LAST_MODIFIED_FILE"
        return 0 # Ha cambiado
    fi
    
    return 1 # No ha cambiado
}

# Procesar el fondo actual al inicio
if [ -f "$WALLPAPER_PATH" ]; then
    apply_wal_theme
    stat -c %Y "$WALLPAPER_PATH" > "$LAST_MODIFIED_FILE"
fi

# Bucle principal de monitoreo
echo "Monitoreando cambios en: $WALLPAPER_PATH"
notify-send -a "$APP_NAME" "Iniciado" "Monitoreando cambios en el fondo de pantalla"

while true; do
    if check_wallpaper_changes; then
        echo "Detectado cambio en el fondo de pantalla. Aplicando nuevo tema..."
        apply_wal_theme
    fi
    sleep $CHECK_INTERVAL
done