#!/usr/bin/env bash

SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] Cargando utilidades..."
fi

setup_sddm_theme() {
    print_header "Configurador Modular de SDDM (hypr-ely-neon Theme)"
    
    local theme_repo="https://github.com/biglexj/hypr-ely-neon.git"
    local tmp_dir="/tmp/hypr-ely-neon-Install"
    
    # 1. Comprobar si SDDM está instalado
    if ! command -v sddm &> /dev/null && [ ! -d "/etc/sddm.conf.d" ]; then
        log_warning "SDDM no está instalado en el sistema actual."
        log_info "Instalando SDDM vía pacman..."
        if [ -f /etc/arch-release ]; then
            request_sudo
            sudo pacman -S --needed --noconfirm sddm
        fi
    fi
    
    request_sudo
    
    # 2. Clonar el repositorio del tema SDDM
    rm -rf "$tmp_dir"
    log_action "Clonando repositorio del tema SDDM hypr-ely-neon desde GitHub..."
    git clone "$theme_repo" "$tmp_dir"
    
    if [ ! -d "$tmp_dir" ]; then
        log_error "No se pudo descargar el repositorio $theme_repo."
        exit 1
    fi
    
    # 3. Buscar e instalar automáticamente archivos de fuentes (.ttf, .otf) incluidos en el tema
    log_action "Buscando e instalando fuentes tipográficas del tema..."
    local font_dest="/usr/share/fonts/sddm-custom-fonts"
    sudo mkdir -p "$font_dest"
    
    # Buscar de forma recursiva cualquier archivo de fuente TTF u OTF
    local fonts_found=$(find "$tmp_dir" -type f \( -name "*.ttf" -o -name "*.otf" \))
    
    if [ -n "$fonts_found" ]; then
        echo "$fonts_found" | while read -r font_path; do
            log_info "Fuente encontrada: $(basename "$font_path"). Copiando a sistema..."
            sudo cp "$font_path" "$font_dest/"
        done
        # Refrescar la caché de fuentes de Linux
        log_action "Actualizando la caché de fuentes del sistema..."
        sudo fc-cache -f &>/dev/null
        log_success "Fuentes del tema SDDM configuradas e instaladas con éxito."
    else
        log_warning "No se encontraron archivos .ttf o .otf directos en el repositorio."
        log_info "Nota: Asegúrate de colocar los archivos de tipografía Kefa, Fira y Ndot en el repositorio para su autoinstalación."
    fi
    
    # 4. Copiar tema a la carpeta de temas de SDDM
    log_action "Instalando el tema '$theme_repo' en /usr/share/sddm/themes/hypr-ely-neon..."
    sudo mkdir -p /usr/share/sddm/themes/hypr-ely-neon
    sudo cp -r "$tmp_dir"/* /usr/share/sddm/themes/hypr-ely-neon/
    
    # 5. Configurar el tema en sddm.conf
    log_action "Estableciendo 'hypr-ely-neon' como el tema activo de SDDM..."
    sudo mkdir -p /etc/sddm.conf.d
    
    # Escribir la configuración de forma segura
    cat << EOF | sudo tee /etc/sddm.conf.d/kde_settings.conf > /dev/null
[Theme]
Current=hypr-ely-neon
CursorTheme=breeze_cursors
EOF
    log_success "Tema configurado exitosamente en /etc/sddm.conf.d/kde_settings.conf."
    
    # 6. Habilitar el servicio en systemd
    if command -v systemctl &> /dev/null; then
        log_action "Habilitando servicio sddm en systemd..."
        sudo systemctl enable sddm.service 2>/dev/null
        log_success "Servicio sddm activado correctamente."
    fi
    
    # 7. Limpieza
    rm -rf "$tmp_dir"
    
    log_success "Instalación del tema SDDM completada con éxito."
}

setup_sddm_theme
