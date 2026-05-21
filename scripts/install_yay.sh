#!/usr/bin/env bash

SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] Cargando utilidades..."
fi

bootstrap_yay() {
    if ! command -v yay &> /dev/null; then
        log_action "yay no está instalado. Instalándolo de forma automática..."
        request_sudo
        sudo pacman -S --needed --noconfirm base-devel git
        
        local tmp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay-bin.git "$tmp_dir/yay-bin"
        cd "$tmp_dir/yay-bin" || exit 1
        makepkg -si --noconfirm
        cd - &>/dev/null || exit
        rm -rf "$tmp_dir"
        
        if command -v yay &> /dev/null; then
            log_success "yay (asistente de AUR) instalado con éxito."
        else
            log_error "Fallo al instalar yay automáticamente."
            exit 1
        fi
    else
        log_info "yay ya se encuentra instalado en el sistema."
    fi
}

install_aur_packages() {
    print_header "Instalador de Paquetes Comunitarios (Yay/AUR)"
    
    # 1. Verificar si es Arch Linux
    if [ ! -f /etc/arch-release ]; then
        log_warning "Este script está diseñado para Arch Linux (yay). Saltando."
        return 0
    fi
    
    # 2. Inicializar yay
    bootstrap_yay
    
    # 3. Lista de aplicaciones AUR requeridas
    local aur_pkgs=(
        "brave-bin"            # Navegador Brave predeterminado
        "yin-yang"             # Auto switch de tema claro/oscuro
        "hyprshade"            # Filtros de color/pantalla en Hyprland
        "waypaper"             # Selector gráfico de wallpapers
        "localsend-bin"        # Intercambio de archivos local
        "qview"                # Visor de imágenes minimalista
        "warp-terminal"        # Terminal Warp (/opt/warpdotdev/warp-terminal/warp)
    )
    
    # 4. Instalar paquetes de AUR
    log_action "Instalando paquetes comunitarios desde AUR..."
    yay -S --needed --noconfirm "${aur_pkgs[@]}"
    
    # 5. Configurar Brave como Navegador Predeterminado
    if command -v brave &>/dev/null; then
        log_action "Estableciendo Brave como el navegador predeterminado del sistema..."
        xdg-settings set default-web-browser brave-browser.desktop 2>/dev/null
        log_success "Brave se ha configurado como navegador predeterminado con éxito."
    else
        log_warning "Brave no parece estar instalado en el PATH. No se pudo establecer como predeterminado."
    fi

    log_success "Instalación de paquetes de AUR completada."
}

install_aur_packages
