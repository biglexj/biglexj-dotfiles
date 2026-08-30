#!/usr/bin/env bash

# Directorio base del script
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$BASE_DIR/scripts"

# Cargar utilidades de diseño
if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo -e "\033[31m[ERROR] No se pudo encontrar el script de utilidades en $SCRIPTS_DIR/utils.sh\033[0m"
    exit 1
fi

show_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo -e "      __    __  .______   .______       _______ .___  ___.  __   __    __  .___  ___. "
    echo -e "     |  |  |  | |   _  \  |   _  \     |   ____||   \/   | |  | |  |  |  | |   \/   | "
    echo -e "     |  |__|  | |  |_)  | |  |_)  |    |  |__   |  \  /  | |  | |  \`--'  | |  \  /  | "
    echo -e "     |   __   | |   ___/  |      /     |   __|  |  |\/|  | |  | |   _  |  | |  |\/|  | "
    echo -e "     |  |  |  | |  |      |  |\  \----.|  |____ |  |  |  | |  | |  | \`--'  | |  |  |  | "
    echo -e "     |__|  |__| | _|      | _| \______||_______||__|  |__| |__| |__|      |__|  |__| "
    echo -e "                                                                                      "
    echo -e "                 💎 Bootstrapper Universal Modular de Dotfiles v1 💎"
    echo -e "${NORMAL}"
    echo -e "${GRAY}--------------------------------------------------------------------------------${NORMAL}"
    echo -e "  Usuario: ${MAGENTA}${BOLD}$USER${NORMAL} | Directorio Base: ${BLUE}${BOLD}$BASE_DIR${NORMAL}"
    echo -e "${GRAY}--------------------------------------------------------------------------------${NORMAL}\n"
}

run_bootstrapper() {
    show_banner
    log_info "Bienvenido a tu instalador automático. Prepara un té y relájate mientras hacemos el trabajo."
    sleep 1.5
    
    # 1. Asegurar permisos de ejecución para sub-scripts
    chmod +x "$SCRIPTS_DIR"/*.sh
    
    # 2. Presentar menú de selección de perfiles premium
    echo -e "\n${BOLD}${CYAN}Selecciona el perfil de instalación deseado:${NORMAL}\n"
    echo -e "  ${BOLD}${GREEN}[1] Perfil Base (Normal)${NORMAL}"
    echo -e "      Instala un entorno de escritorio Hyprland premium, moderno y optimizado."
    echo -e "      Incluye: Hyprland, Waybar, Rofi, Kitty, Dunst, Brave (predeterminado),"
    echo -e "      swww, waypaper, localsend-bin, y los temas unificados Zsh/SDDM."
    echo -e ""
    echo -e "  ${BOLD}${MAGENTA}[2] Perfil Prime (Vitamina / Premium Completo)${NORMAL}"
    echo -e "      Incluye todo el stack del Perfil Base, y además añade:"
    echo -e "      Herramientas Creativas/Dev: OBS Studio, Krita, Blender, VS Code y Kvantum."
    echo -e "      Sistema de dictado por voz interactivo y offline Vocalinux."
    echo -e ""
    echo -e "  ${BOLD}${RED}[3] Salir${NORMAL}"
    echo -e ""
    
    local profile=""
    while true; do
        echo -n -e "${BOLD}${YELLOW}Elige una opción [1-3]: ${NORMAL}"
        read -r choice
        case "$choice" in
            1)
                profile="base"
                log_success "Perfil seleccionado: BASE (Normal)"
                break
                ;;
            2)
                profile="prime"
                log_success "Perfil seleccionado: PRIME (Premium Completo)"
                break
                ;;
            3)
                log_info "Instalación cancelada por el usuario. ¡Hasta luego!"
                exit 0
                ;;
            *)
                log_error "Opción no válida. Por favor, selecciona 1, 2 o 3."
                ;;
        esac
    done
    
    echo -e "\n${GRAY}Iniciando instalación del perfil seleccionado en 3 segundos...${NORMAL}"
    sleep 3
    
    # ==================== BLOQUE DE INSTALACIÓN BASE ====================
    print_header "Fase 1: Instalación del Sistema Base Desktop"
    
    # A. Ejecutar instalador nativo del sistema (pacman en Arch)
    #    Desinstala Firefox automáticamente e instala apps base
    if [ -f "$SCRIPTS_DIR/install_pacman.sh" ]; then
        bash "$SCRIPTS_DIR/install_pacman.sh" || { log_error "install_pacman.sh falló. Abortando."; exit 1; }
    else
        log_error "No se encontró el script install_pacman.sh en $SCRIPTS_DIR"
        exit 1
    fi
    
    # B. Ejecutar instalador de paquetes de la comunidad (yay/AUR en Arch)
    #    Autoinstala yay y el navegador Brave como predeterminado
    if [ -f "$SCRIPTS_DIR/install_yay.sh" ]; then
        bash "$SCRIPTS_DIR/install_yay.sh"
    else
        log_error "No se encontró el script install_yay.sh en $SCRIPTS_DIR"
        exit 1
    fi
    
    # C. Ejecutar validador de Python/Pip
    if [ -f "$SCRIPTS_DIR/install_pip.sh" ]; then
        bash "$SCRIPTS_DIR/install_pip.sh"
    fi
    
    # D. Configurar el tema y complementos de terminal Zsh
    if [ -f "$SCRIPTS_DIR/setup_zsh.sh" ]; then
        bash "$SCRIPTS_DIR/setup_zsh.sh"
    fi
    
    # E. Configurar el tema de pantalla SDDM y sus fuentes locales
    if [ -f "$SCRIPTS_DIR/setup_sddm.sh" ]; then
        bash "$SCRIPTS_DIR/setup_sddm.sh"
    fi
    
    # F. Symlinks del dotfiles (kde-init, .zshrc, y todo .config/ -> dotfiles)
    if [ -f "$SCRIPTS_DIR/setup_dotfiles_links.sh" ]; then
        bash "$SCRIPTS_DIR/setup_dotfiles_links.sh"
    fi

    # ==================== BLOQUE DE INSTALACIÓN PRIME ====================
    if [ "$profile" = "prime" ]; then
        print_header "Fase 2: Instalación de la Suite Prime (Vitamina)"
        
        # A. Instalar paquetes creativos y de desarrollo Prime
        if [ -f "$SCRIPTS_DIR/install_prime.sh" ]; then
            bash "$SCRIPTS_DIR/install_prime.sh"
        else
            log_error "No se encontró el script install_prime.sh en $SCRIPTS_DIR"
            exit 1
        fi
        
        # B. Instalar y configurar Vocalinux interactivo para el dictado por voz
        if [ -f "$SCRIPTS_DIR/setup_vocalinux.sh" ]; then
            bash "$SCRIPTS_DIR/setup_vocalinux.sh"
        else
            log_error "No se encontró el script setup_vocalinux.sh en $SCRIPTS_DIR"
            exit 1
        fi

        # Aviso AppImages — solo en perfil Prime
        echo -e "\n${YELLOW}${BOLD}╔══════════════════════════════════════════════════════════════╗${NORMAL}"
        echo -e "${YELLOW}${BOLD}║        📦 APPS QUE REQUIEREN INSTALACIÓN MANUAL              ║${NORMAL}"
        echo -e "${YELLOW}${BOLD}╚══════════════════════════════════════════════════════════════╝${NORMAL}"
        echo -e "${GRAY}  Las siguientes apps son AppImages — descárgalas y colócalas${NORMAL}"
        echo -e "${GRAY}  en la carpeta indicada para que los atajos de Hyprland funcionen:${NORMAL}\n"
        echo -e "  ${CYAN}📁 ~/AppImage-Apps/MuseScore/${NORMAL}"
        echo -e "  ${GRAY}     → https://musescore.org/en/download${NORMAL}"
        echo -e "  ${CYAN}📁 ~/AppImage-Apps/Neothesia/${NORMAL}"
        echo -e "  ${GRAY}     → https://github.com/PolyMeilex/Neothesia/releases${NORMAL}"
        echo -e "  ${CYAN}📁 ~/AppImage-Apps/Telegram/${NORMAL}"
        echo -e "  ${GRAY}     → https://desktop.telegram.org/${NORMAL}"
        echo -e "  ${CYAN}📁 ~/AppImage-Apps/Heroic-Games-Launcher/${NORMAL}"
        echo -e "  ${GRAY}     → https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases${NORMAL}"
        echo -e "  ${CYAN}📁 ~/AppImage-Apps/Upscayl/${NORMAL}"
        echo -e "  ${GRAY}     → https://github.com/upscayl/upscayl/releases${NORMAL}"
        echo -e ""
    fi
    
    # Finalización
    print_header "¡Proceso de Instalación Finalizado!"
    log_success "Se ha instalado tu perfil [$profile] de forma exitosa."
    log_info "Te recomendamos reiniciar la computadora para aplicar el cambio de shell Zsh y arrancar con SDDM / Hyprland."
    echo -e "\n${GREEN}${BOLD}¡Disfruta de tu entorno de escritorio premium! 🍵✨${NORMAL}\n"
}

# Iniciar bootstrapper
run_bootstrapper
