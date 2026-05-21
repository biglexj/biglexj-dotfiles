#!/usr/bin/env bash

SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] Cargando utilidades..."
fi

install_pip_packages() {
    print_header "Instalador de Paquetes de Python (Pip)"
    
    # 1. Comprobar si Python y Pip están instalados
    if ! command -v python3 &> /dev/null; then
        log_warning "Python 3 no está instalado. Instalándolo vía gestor de paquetes nativo..."
        if [ -f /etc/arch-release ]; then
            request_sudo
            sudo pacman -S --needed --noconfirm python python-pip
        fi
    fi
    
    # Asegurar que pip está disponible
    if ! command -v pip3 &> /dev/null && ! python3 -m pip --version &> /dev/null; then
        log_error "Pip no está disponible en este sistema. Por favor instalalo manualmente."
        exit 1
    fi
    
    log_info "Entorno de Python y Pip listo."
    
    # Nota: Las dependencias de dictado por voz (como pyaudio y vosk) se manejan de manera aislada 
    # en un entorno virtual propio creado por Vocalinux, lo cual es la mejor práctica en Linux moderno.
    
    log_success "Módulo de instalación de Python/Pip completado."
}

install_pip_packages
