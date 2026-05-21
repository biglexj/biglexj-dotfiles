#!/usr/bin/env bash

# Directorio de scripts
SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] Cargando utilidades..."
fi

# ─────────────────────────────────────────────────────────────────────────────
# Instalar paquetes creativos y de desarrollo vía pacman
# ─────────────────────────────────────────────────────────────────────────────
install_prime_packages() {
    print_header "Instalador de Paquetes Prime (Creative & Dev)"

    # 1. Verificar si es Arch Linux
    if [ ! -f /etc/arch-release ]; then
        log_warning "Este script está diseñado para Arch Linux (pacman). Saltando."
        return 0
    fi

    request_sudo

    # 2. Lista de aplicaciones Prime
    local prime_pkgs=(
        "obs-studio"   # Grabador y transmisor de video
        "krita"        # Software de pintura digital e ilustración
        "blender"      # Modelado y animación 3D
        "code"         # Visual Studio Code (OSS Build)
    )

    log_action "Instalando herramientas creativas y de desarrollo para el Perfil Prime..."
    sudo pacman -S --needed --noconfirm "${prime_pkgs[@]}"

    if [ $? -eq 0 ]; then
        log_success "¡Todos los paquetes de la suite Prime se instalaron con éxito! 🎨💻"
    else
        log_error "Hubo un problema al instalar algunos paquetes de la suite Prime."
        exit 1
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Instaladores de AI Coding Tools
# ─────────────────────────────────────────────────────────────────────────────
install_opencode() {
    log_action "Instalando OpenCode..."
    curl -fsSL https://opencode.ai/install | bash
    if command -v opencode &>/dev/null || [ -f "$HOME/.opencode/bin/opencode" ]; then
        # Asegurar que el PATH esté en .zshrc
        if ! grep -q "opencode" "$HOME/.zshrc" 2>/dev/null; then
            echo "" >> "$HOME/.zshrc"
            echo "# opencode" >> "$HOME/.zshrc"
            echo 'export PATH=/home/biglexj/.opencode/bin:$PATH' >> "$HOME/.zshrc"
        fi
        log_success "OpenCode instalado correctamente. 🤖"
    else
        log_error "Falló la instalación de OpenCode."
    fi
}

install_antigravity() {
    log_action "Instalando Antigravity CLI (Google DeepMind)..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
    if command -v antigravity &>/dev/null; then
        log_success "Antigravity CLI instalado correctamente. 🚀"
    else
        log_error "Falló la instalación de Antigravity CLI."
    fi
}

install_claude_code() {
    log_action "Verificando Node.js (requerido para Claude Code)..."
    if ! command -v node &>/dev/null; then
        log_warning "Node.js no está instalado. Instalándolo..."
        if [ -f /etc/arch-release ]; then
            sudo pacman -S --needed --noconfirm nodejs npm
        else
            log_error "Instala Node.js 18+ manualmente y vuelve a ejecutar."
            return 1
        fi
    fi

    local node_version
    node_version=$(node -e "process.exit(parseInt(process.version.slice(1)) < 18 ? 1 : 0)" 2>/dev/null && echo "ok" || echo "old")
    if [ "$node_version" = "old" ]; then
        log_warning "Node.js < 18 detectado. Claude Code requiere Node.js 18+."
        log_info "Actualiza Node.js y vuelve a ejecutar."
        return 1
    fi

    log_action "Instalando Claude Code..."
    npm install -g @anthropic-ai/claude-code
    if command -v claude &>/dev/null; then
        log_success "Claude Code instalado correctamente. 🟣"
        log_info "Ejecuta 'claude' en tu proyecto para autenticarte."
    else
        log_error "Falló la instalación de Claude Code."
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Menú interactivo de AI Coding Tools
# ─────────────────────────────────────────────────────────────────────────────
select_ai_tools() {
    print_header "🤖 AI Coding Tools — Selección de Herramientas"

    echo -e "\n${BOLD}${CYAN}¿Qué herramientas de AI coding deseas instalar?${NORMAL}\n"
    echo -e "  ${BOLD}${GREEN}[1]${NORMAL} OpenCode           — Terminal AI coding assistant"
    echo -e "  ${BOLD}${BLUE}[2]${NORMAL} Antigravity CLI    — Google DeepMind AI coding agent"
    echo -e "  ${BOLD}${MAGENTA}[3]${NORMAL} Claude Code        — Anthropic AI coding agent (requiere Node.js 18+)"
    echo -e "  ${BOLD}${YELLOW}[4]${NORMAL} Instalar TODAS"
    echo -e "  ${BOLD}${RED}[5]${NORMAL} Saltar (no instalar ninguna)"
    echo ""

    local selection=""
    while true; do
        echo -n -e "${BOLD}${YELLOW}Elige una o varias opciones separadas por espacio [1-5]: ${NORMAL}"
        read -r selection

        # Validar que solo contenga números del 1 al 5
        if echo "$selection" | grep -qE '^[1-5]( [1-5])*$'; then
            break
        else
            log_error "Entrada inválida. Usa números del 1 al 5 separados por espacio (ej: 1 3)."
        fi
    done

    # Si eligió "Saltar"
    if echo "$selection" | grep -q "5"; then
        log_info "Instalación de AI Coding Tools omitida."
        return 0
    fi

    # Si eligió "Todas" o combinación
    if echo "$selection" | grep -q "4"; then
        selection="1 2 3"
    fi

    for opt in $selection; do
        case "$opt" in
            1) install_opencode ;;
            2) install_antigravity ;;
            3) install_claude_code ;;
        esac
    done

    log_success "✅ Instalación de AI Coding Tools completada."
    log_info "Reinicia o ejecuta 'source ~/.zshrc' para aplicar los PATHs nuevos."
}

# ─────────────────────────────────────────────────────────────────────────────
# Punto de entrada
# ─────────────────────────────────────────────────────────────────────────────
install_prime_packages
select_ai_tools
