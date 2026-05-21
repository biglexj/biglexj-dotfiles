#!/usr/bin/env bash

SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] Cargando utilidades..."
fi

setup_vocalinux() {
    print_header "Instalador del Sistema de Voz (Vocalinux)"
    
    log_info "Este módulo descargará y ejecutará el instalador oficial interactivo de Vocalinux."
    log_info "Vocalinux es un sistema de dictado por voz 100% offline, rápido y respetuoso con la privacidad."
    
    # 1. Mensaje de confirmación interactiva
    echo -n -e "\n${YELLOW}${BOLD}¿Deseas iniciar el instalador de Vocalinux ahora mismo? [s/N]: ${NORMAL}"
    read -r response
    
    if [[ "$response" =~ ^([sS][iI]|[sS])$ ]]; then
        log_action "Descargando e iniciando instalador interactivo de Vocalinux..."
        sleep 1
        
        # Ejecutar instalador oficial
        curl -fsSL https://raw.githubusercontent.com/jatinkrmalik/vocalinux/main/install.sh | bash
        
        # 2. Rutina de Auto-Corrección para pywhispercpp (libwhisper.so.1)
        #    Esto soluciona los problemas de enlace dinámico en CachyOS/Arch
        local vocal_venv="$HOME/.local/share/vocalinux/venv"
        
        if [ -d "$vocal_venv" ]; then
            log_action "Aplicando auto-corrección para pywhispercpp en el entorno virtual..."
            
            # Como este script del instalador se ejecuta bajo Bash, podemos activar el venv de forma segura
            if [ -f "$vocal_venv/bin/activate" ]; then
                source "$vocal_venv/bin/activate"
                log_info "Entorno virtual de Vocalinux activado bajo Bash."
                log_info "Forzando la compilación nativa de pywhispercpp (esto evitará el fallo de libwhisper.so.1)..."
                
                # Compilar nativamente usando el compilador local GCC/CMake
                pip install --force-reinstall --no-cache-dir pywhispercpp
                
                if [ $? -eq 0 ]; then
                    log_success "pywhispercpp compilado nativamente y reinstalado de forma exitosa."
                else
                    log_error "Fallo al compilar o reinstalar pywhispercpp."
                fi
                
                deactivate
                log_info "Entorno virtual desactivado."
            else
                log_warning "No se pudo encontrar el archivo de activación de venv en $vocal_venv/bin/activate"
            fi
        else
            log_warning "No se pudo encontrar el entorno virtual de Vocalinux en $vocal_venv"
        fi
        
        log_success "Instalación y corrección de Vocalinux finalizadas."
        log_info "Puedes configurar atajos (como SUPER + D) y motores locales de voz desde su interfaz."
    else
        log_info "Instalación de Vocalinux omitida por el usuario."
    fi
}

setup_vocalinux
