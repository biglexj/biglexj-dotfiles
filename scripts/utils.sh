#!/usr/bin/env bash

# Colores ANSI y Estilos
export BOLD='\033[1m'
export NORMAL='\033[0m'

# Paleta de colores Premium
export RED='\033[38;2;235;94;85m'      # Coral/Rojo vibrante
export GREEN='\033[38;2;122;186;120m'  # Verde Menta
export YELLOW='\033[38;2;244;208;111m' # Oro/Amarillo
export CYAN='\033[38;2;74;189;172m'    # Azul Verde Turquesa
export MAGENTA='\033[38;2;186;104;200m'# Violeta Lavanda
export BLUE='\033[38;2;90;156;230m'    # Azul Real
export GRAY='\033[38;2;150;150;150m'    # Gris Medio

# Iconos UTF-8 para estados
export ICON_INFO="ℹ️ "
export ICON_SUCCESS="✔️ "
export ICON_WARNING="⚠️ "
export ICON_ERROR="❌ "
export ICON_ACTION="🚀 "
export ICON_WORKING="⚙️ "

# Funciones de Logging Estilizadas
log_info() {
    echo -e "${CYAN}${ICON_INFO}${BOLD}[INFO]${NORMAL} $1"
}

log_success() {
    echo -e "${GREEN}${ICON_SUCCESS}${BOLD}[ÉXITO]${NORMAL} $1"
}

log_warning() {
    echo -e "${YELLOW}${ICON_WARNING}${BOLD}[AVISO]${NORMAL} $1"
}

log_error() {
    echo -e "${RED}${ICON_ERROR}${BOLD}[ERROR]${NORMAL} $1" >&2
}

log_action() {
    echo -e "${MAGENTA}${ICON_ACTION}${BOLD}[ACCIÓN]${NORMAL} $1"
}

# Líneas de cabeceras visualmente impresionantes
print_header() {
    local title="$1"
    echo -e "\n${BLUE}========================================================================${NORMAL}"
    echo -e "${BLUE}${BOLD}   $title${NORMAL}"
    echo -e "${BLUE}========================================================================${NORMAL}\n"
}

# Pequeña animación de espera (spinner)
show_spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    echo -n "   "
    while [ "$(ps a | awk '{print $1}' | grep "$pid")" ]; do
        local temp=${spinstr#?}
        printf "[%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Solicitar elevación de privilegios de forma segura
request_sudo() {
    if [ "$EUID" -ne 0 ]; then
        log_info "Esta operación requiere privilegios de administrador (sudo)."
        if sudo -v; then
            # Mantener sudo activo en segundo plano durante la ejecución
            while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
            log_success "Privilegios sudo concedidos correctamente."
        else
            log_error "No se pudieron obtener privilegios sudo. Cancelando."
            exit 1
        fi
    fi
}
