#!/usr/bin/env bash
# setup_dotfiles_links.sh
# Crea los symlinks desde el dotfiles al sistema:
#   ~/.local/bin/kde-init -> dotfiles/scripts/kde-init
#   ~/.zshrc              -> dotfiles/home/.zshrc
#
# Idempotente: si el symlink ya apunta al destino correcto, no hace nada.
# Si apunta a otro lado o es archivo regular, respalda y reemplaza.

SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
BASE_DIR="$(cd "$SCRIPTS_DIR/.." && pwd)"

if [ -f "$SCRIPTS_DIR/utils.sh" ]; then
    source "$SCRIPTS_DIR/utils.sh"
else
    echo "[INFO] utils.sh no encontrado; usando logs basicos."
    log_info()    { echo -e "\033[36m[INFO]\033[0m $1"; }
    log_success() { echo -e "\033[32m[OK]\033[0m $1"; }
    log_warning() { echo -e "\033[33m[WARN]\033[0m $1"; }
    log_error()   { echo -e "\033[31m[ERR]\033[0m $1" >&2; }
fi

BACKUP_DIR="$HOME/.config/dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

link_target() {
    local label="$1"
    local target="$2"
    local link_path="$3"

    if [ ! -e "$target" ] && [ ! -L "$target" ]; then
        log_error "Origen no existe: $target"
        return 1
    fi

    if [ -L "$link_path" ]; then
        local current
        current=$(readlink "$link_path")
        if [ "$current" = "$target" ]; then
            log_info "$label: symlink ya correcto -> $current"
            return 0
        fi
        log_warning "$label: symlink apuntaba a '$current'. Reemplazando..."
        rm -f "$link_path"
    elif [ -e "$link_path" ]; then
        mkdir -p "$BACKUP_DIR"
        cp -a "$link_path" "$BACKUP_DIR/"
        log_warning "$label: archivo existente respaldado en $BACKUP_DIR"
        rm -f "$link_path"
    fi

    mkdir -p "$(dirname "$link_path")"
    ln -s "$target" "$link_path"
    log_success "$label: $link_path -> $target"
}

setup_dotfiles_links() {
    print_header "Symlinks del Dotfiles (kde-init, .zshrc)"

    link_target "kde-init"  "$BASE_DIR/scripts/kde-init" "$HOME/.local/bin/kde-init"
    chmod +x "$BASE_DIR/scripts/kde-init" 2>/dev/null
    link_target ".zshrc"    "$BASE_DIR/home/.zshrc"      "$HOME/.zshrc"

    log_success "Symlinks del dotfiles listos."
    log_info "Recarga tu shell: source ~/.zshrc"
}

setup_dotfiles_links
