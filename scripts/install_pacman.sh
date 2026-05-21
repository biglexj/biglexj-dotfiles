#!/usr/bin/env bash

SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] Cargando utilidades..."
fi

install_pacman_packages() {
    print_header "Instalador de Paquetes del Sistema (Pacman)"
    
    # 1. Verificar si es Arch Linux
    if [ ! -f /etc/arch-release ]; then
        log_warning "Este script está diseñado para Arch Linux (pacman). Saltando."
        return 0
    fi
    
    request_sudo
    
    # 2. Desinstalar Firefox si se encuentra presente
    if command -v firefox &> /dev/null || pacman -Qs "^firefox$" &> /dev/null; then
        log_action "Desinstalando Firefox del sistema..."
        sudo pacman -Rns --noconfirm firefox &>/dev/null
        log_success "Firefox ha sido desinstalado correctamente."
    else
        log_info "Firefox no está instalado en el sistema. Omitiendo desinstalación."
    fi
    
    # 3. Lista de aplicaciones leídas desde binds-apps.conf y autostart.conf
    local system_pkgs=(
        # Herramientas Base
        "git" "curl" "wget" "unzip" "sox" "dbus" "polkit"
        # Terminales y Editores
        "kitty" "konsole" "kate" "micro" "neovim"
        # Suite Hyprland & Servicios de Escritorio
        "hyprland" "hypridle" "hyprlock" "waybar" "dunst" "wl-clipboard" "cliphist" "awww"
        # Notificaciones
        "swaync"
        # Gestión y Utilidades
        "pcmanfm" "dolphin" "rofi" "wofi" "udiskie" "fastfetch" "lsd" "ranger"
        # Temas Qt
        "kvantum" "qt5ct" "qt6ct"
        # Imagen y Gráficos
        "kcolorchooser" "kolourpaint" "gwenview"
        # Audio y Video
        "audacity" "elisa" "vlc" "kid3"
        # Logout / Sesión
        "wlogout"
        # Otras aplicaciones
        "scrcpy"
    )
    
    # 4. Sincronizar bases de datos e instalar
    log_action "Sincronizando base de datos de pacman e instalando paquetes..."
    sudo pacman -Sy --needed --noconfirm "${system_pkgs[@]}"
    
    if [ $? -eq 0 ]; then
        log_success "Todos los paquetes nativos de pacman se instalaron con éxito."
    else
        log_error "Hubo un problema al instalar algunos paquetes vía pacman."
        exit 1
    fi
}

install_pacman_packages
