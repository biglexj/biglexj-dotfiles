#!/usr/bin/env bash

SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
BASE_DIR="$(cd "$SCRIPTS_DIR/.." && pwd)"

if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] Cargando utilidades..."
fi

setup_zsh_config() {
    print_header "Configurador Completo de Zsh + Oh My Zsh + Plugins (Biglex Setup)"

    # ─────────────────────────────────────────────
    # 1. Instalar Zsh si no existe
    # ─────────────────────────────────────────────
    if ! command -v zsh &> /dev/null; then
        log_warning "Zsh no está instalado. Instalándolo..."
        if [ -f /etc/arch-release ]; then
            request_sudo
            sudo pacman -S --needed --noconfirm curl git zsh
        elif command -v apt &> /dev/null; then
            request_sudo
            sudo apt update && sudo apt install -y curl git zsh
        else
            log_error "Distribución no soportada. Instala zsh manualmente."
            exit 1
        fi
    else
        log_success "Zsh ya instalado: $(zsh --version)"
    fi

    # ─────────────────────────────────────────────
    # 2. Instalar Oh My Zsh (modo desatendido)
    # ─────────────────────────────────────────────
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_info "Oh My Zsh ya está instalado. Saltando..."
    else
        log_action "Instalando Oh My Zsh (modo desatendido)..."
        # CHSH=no evita que el instalador cambie la shell (lo hacemos nosotros más abajo)
        # RUNZSH=no evita que arranque zsh al terminar (para no interrumpir el script)
        CHSH=no RUNZSH=no KEEP_ZSHRC=yes \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            log_error "Falló la instalación de Oh My Zsh."
            exit 1
        fi
        log_success "Oh My Zsh instalado correctamente."
    fi

    # ─────────────────────────────────────────────
    # 3. Instalar plugins esenciales
    # ─────────────────────────────────────────────
    local PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    mkdir -p "$PLUGINS_DIR"

    if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
        log_action "Instalando plugin: zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
        log_success "zsh-autosuggestions instalado."
    else
        log_info "zsh-autosuggestions ya instalado."
    fi

    if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
        log_action "Instalando plugin: zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
        log_success "zsh-syntax-highlighting instalado."
    else
        log_info "zsh-syntax-highlighting ya instalado."
    fi

    if [ ! -d "$PLUGINS_DIR/zsh-completions" ]; then
        log_action "Instalando plugin: zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions "$PLUGINS_DIR/zsh-completions"
        log_success "zsh-completions instalado."
    else
        log_info "zsh-completions ya instalado."
    fi

    # ─────────────────────────────────────────────
    # 4. Aplicar .zshrc desde el dotfiles (preferir local sobre repo externo)
    # ─────────────────────────────────────────────
    local local_zshrc="$BASE_DIR/home/.zshrc"
    local backup_path="$HOME/.config/dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_path"

    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        cp "$HOME/.zshrc" "$backup_path/.zshrc.bak"
        log_success "Respaldo del .zshrc guardado en $backup_path"
    fi

    if [ -f "$local_zshrc" ]; then
        log_info ".zshrc local encontrado en $local_zshrc. Creando symlink..."
        rm -f "$HOME/.zshrc"
        ln -s "$local_zshrc" "$HOME/.zshrc"
        log_success ".zshrc enlazado a $local_zshrc"

        if [ -d "$BASE_DIR/home/.zsh" ]; then
            rm -rf "$HOME/.zsh"
            ln -s "$BASE_DIR/home/.zsh" "$HOME/.zsh"
            log_success "Carpeta .zsh enlazada desde el dotfiles."
        fi
    else
        # Fallback: clonar repo externo (comportamiento legacy)
        local theme_repo="https://github.com/biglexj/Terminal-Linux-Theme.git"
        local tmp_dir="/tmp/Terminal-Linux-Theme-Install"

        rm -rf "$tmp_dir"
        log_action "No se encontró home/.zshrc local. Clonando repositorio externo..."
        git clone "$theme_repo" "$tmp_dir"

        if [ ! -d "$tmp_dir" ]; then
            log_error "No se pudo descargar el repositorio $theme_repo."
            exit 1
        fi

        local src_folder=""
        if [ -f /etc/arch-release ]; then
            log_info "Sistema Arch detectado."
            src_folder="$tmp_dir/Arch"
        else
            log_info "Sistema Debian/Otros detectado."
            src_folder="$tmp_dir/Debian"
        fi

        if [ -d "$src_folder" ]; then
            if [ -f "$src_folder/.zshrc" ]; then
                cp "$src_folder/.zshrc" "$HOME/.zshrc"
                log_success ".zshrc copiado a $HOME/."
            fi
            if [ -d "$src_folder/zsh" ]; then
                rm -rf "$HOME/.zsh"
                cp -r "$src_folder/zsh" "$HOME/.zsh"
                log_success "Carpeta .zsh copiada a $HOME/.zsh."
            fi
        else
            log_error "No se encontró la carpeta $src_folder en el repositorio clonado."
            exit 1
        fi

        rm -rf "$tmp_dir"
    fi

    # ─────────────────────────────────────────────
    # 5. Asegurar PATH de opencode en .zshrc
    # ─────────────────────────────────────────────
    if ! grep -q "opencode" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# opencode" >> "$HOME/.zshrc"
        echo 'export PATH=/home/biglexj/.opencode/bin:$PATH' >> "$HOME/.zshrc"
        log_success "PATH de opencode añadido al .zshrc."
    else
        log_info "PATH de opencode ya presente en .zshrc."
    fi

    # ─────────────────────────────────────────────
    # 6. Copiar configs de .conf/ a ~/.config/ (sin symlinks)
    # ─────────────────────────────────────────────
    local conf_src="$BASE_DIR/.config"
    local conf_dest="$HOME/.config"
    local conf_backup="$HOME/.config/dotfiles_backup/$(date +%Y%m%d_%H%M%S)_conf"

    if [ -d "$conf_src" ] && [ "$(ls -A "$conf_src")" ]; then
        mkdir -p "$conf_backup"
        log_action "Copiando configuraciones de .conf/ a ~/.config/ (reemplazando existentes)..."

        for folder_path in "$conf_src"/*/; do
            if [ -d "$folder_path" ]; then
                local folder_name
                folder_name=$(basename "$folder_path")
                local dest_folder="$conf_dest/$folder_name"

                # Respaldar si existe (sea archivo, carpeta o symlink)
                if [ -e "$dest_folder" ] || [ -L "$dest_folder" ]; then
                    cp -r "$dest_folder" "$conf_backup/" 2>/dev/null
                    rm -rf "$dest_folder"
                    log_info "Respaldo de $folder_name guardado."
                fi

                # Copiar (no symlink)
                cp -r "$folder_path" "$dest_folder"
                log_success "Configuración copiada: ~/.config/$folder_name"
            fi
        done
        log_success "Todas las configuraciones de .conf/ aplicadas correctamente."

        # Dar permisos de ejecución a todos los scripts de biglexj
        if [ -d "$HOME/.config/biglexj" ]; then
            find "$HOME/.config/biglexj" -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} \;
            chmod +x "$HOME/.config/biglexj/control-center/wifimenu" 2>/dev/null
            log_success "Permisos de ejecución aplicados a scripts (.sh, .py) de ~/.config/biglexj/."
        fi

        # Dar permisos de ejecución a los scripts de waybar
        if [ -d "$HOME/.config/waybar/scripts" ]; then
            chmod +x "$HOME/.config/waybar/scripts/"* 2>/dev/null
            log_success "Permisos de ejecución aplicados a scripts de ~/.config/waybar/."
        fi

    else
        log_warning "No se encontraron configuraciones en $conf_src/. Saltando copia de .conf/."
    fi

    # ─────────────────────────────────────────────
    # 6.5. Copiar wallpapers al home
    # ─────────────────────────────────────────────
    local wall_src="$BASE_DIR/Wallpapers"
    local wall_dest="$HOME/Imágenes/Wallpapers"

    if [ -d "$wall_src" ]; then
        log_action "Copiando/actualizando wallpapers en ~/Imágenes/Wallpapers..."
        mkdir -p "$wall_dest"
        # Copiar recursivamente. cp -r con punto final copia el contenido sin recrear la carpeta padre.
        cp -r "$wall_src/." "$wall_dest/"
        log_success "Wallpapers copiados a $wall_dest/"
    else
        log_warning "No se encontró el directorio de wallpapers en $wall_src. Saltando copia."
    fi


    # ─────────────────────────────────────────────
    # 7. Limpieza
    # ─────────────────────────────────────────────
    rm -rf "$tmp_dir"

    # ─────────────────────────────────────────────
    # 8. Cambiar Shell por defecto a Zsh
    # ─────────────────────────────────────────────
    if [ "$SHELL" != "$(which zsh)" ]; then
        log_action "Configurando Zsh como shell predeterminada..."
        chsh -s "$(which zsh)"
        log_success "Shell cambiada a Zsh. Reinicia sesión para aplicar."
    else
        log_info "Zsh ya es la shell predeterminada."
    fi

    # ─────────────────────────────────────────────
    # Limpieza temporal del repo de temas
    # ─────────────────────────────────────────────
    rm -rf "$tmp_dir"

    log_success "✅ Configuración de Zsh + Oh My Zsh + Plugins finalizada con éxito."
    log_info "Recarga tu terminal o ejecuta: source ~/.zshrc"
}

setup_zsh_config
