# ===========================
# 🚀 .zshrc - Biglex J Edition (Arch)
# ===========================

export ZSH="$HOME/.oh-my-zsh"
ENABLE_CORRECTION="true"

# ===========================
# 🎨 Prompt personalizado
# ===========================
PROMPT='%F{cyan}󰣇 %f %F{magenta}%n%f $(dir_icon) %F{red}%~%f${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{green}.%F{red})%f%b '

# ===========================
# 🔌 Plugins
# ===========================
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    sudo
    extract
    web-search
)
source $ZSH/oh-my-zsh.sh

# ===========================
# 🌈 Syntax Highlighting Colors
# ===========================
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF4C70,bold'
ZSH_HIGHLIGHT_STYLES[bad-command]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#00AAFF,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=#00F5CE,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#00F5CE,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00F5CE,bold'

# ===========================
# 🎨 Funciones del Prompt
# ===========================
setopt prompt_subst

function dir_icon {
    if [[ "$PWD" == "$HOME" ]]; then
        echo "%{%B%F{white}%}%{%f%b%}"
    else
        echo "%{%B%F{cyan}%}%{%f%b%}"
    fi
}

function parse_git_branch {
    local branch
    branch=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ -n "$branch" ]; then
        echo " [$branch]"
    fi
}

# Habilitar vcs_info para mostrar rama de git
autoload -U add-zsh-hook
load-vcs-info() {
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git*' formats ' [%b]'
    zstyle ':vcs_info:git*' actionformats ' [%b|%a]'
    zstyle ':vcs_info:git*' check-for-changes true
}
add-zsh-hook precmd load-vcs-info

# Deshabilitar colores en ls (si no quieres colorear)
# unset LS_COLORS
# export LS_COLORS=""

# ===========================
# 🎨 Banner ASCII de Bienvenida
# ===========================
function show_banner {
    local colors=(
        '\033[0;36m'  # Cyan
        '\033[0;35m'  # Magenta
        '\033[0;33m'  # Yellow
        '\033[0;32m'  # Green
    )
    local color=${colors[$RANDOM % ${#colors[@]}]}
    local reset='\033[0m'
    
    echo -e "${color}╔═════════════════════════════════════════════════════════════════╗${reset}"
    echo -e "${color}║                                                                 ║${reset}"
    echo -e "${color}║      ██████╗ ██╗ ██████╗ ██╗     ███████╗██╗  ██╗      ██╗      ║${reset}"
    echo -e "${color}║      ██╔══██╗██║██╔════╝ ██║     ██╔════╝╚██╗██╔╝      ██║      ║${reset}"
    echo -e "${color}║      ██████╔╝██║██║  ███╗██║     █████╗   ╚███╔╝       ██║      ║${reset}"
    echo -e "${color}║      ██╔══██╗██║██║   ██║██║     ██╔══╝   ██╔██╗       ██║      ║${reset}"
    echo -e "${color}║      ██████╔╝██║╚██████╔╝███████╗███████╗██╔╝ ██╗   ██╗██║      ║${reset}"
    echo -e "${color}║      ╚═════╝ ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝╚═╝      ║${reset}"
    echo -e "${color}║                                                                 ║${reset}"
    echo -e "${color}║              W E L C O M E   T O   B I G L E X - J              ║${reset}"
    echo -e "${color}║                                                                 ║${reset}"
    echo -e "${color}║           Arch/Hyprland Edition • Build: CREATOR-EDITION        ║${reset}"
    echo -e "${color}║                                                                 ║${reset}"
    echo -e "${color}║     🎨 Content Creator | 💻 Developer | 🎵 JPop Enthusiast      ║${reset}"
    echo -e "${color}║     🚀 C# • React • Python | 🎬 DaVinci • Blender • OBS         ║${reset}"
    echo -e "${color}║                                                                 ║${reset}"
    echo -e "${color}║              > Ready to create amazing content...               ║${reset}"
    echo -e "${color}║                                                                 ║${reset}"
    echo -e "${color}╚═════════════════════════════════════════════════════════════════╝${reset}"
}

# ===========================
# ℹ️ Info del Sistema
# ===========================
function show_system_info {
    local uptime_info=$(uptime -p | sed 's/up //')
    local os_info=$(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)
    local date_info=$(date '+%d/%m/%Y %H:%M')
    
    echo -e "\033[0;32m┌─────────────────────────────────────────────────────────────────┐\033[0m"
    echo -e "\033[0;32m│\033[0m \033[0;36mS.O\033[0m       │ $os_info"
    echo -e "\033[0;33m│\033[0m \033[0;33mEquipo\033[0m    │ $(hostname)"
    echo -e "\033[0;35m│\033[0m \033[0;35mUsuario\033[0m   │ $USER"
    echo -e "\033[0;34m│\033[0m \033[0;34mUptime\033[0m    │ $uptime_info"
    echo -e "\033[0;36m│\033[0m \033[0;36mFecha\033[0m     │ $date_info"
    echo -e "\033[0;31m│\033[0m \033[0;31mShell\033[0m     │ zsh $ZSH_VERSION"
    echo -e "\033[0;32m└─────────────────────────────────────────────────────────────────┘\033[0m"
}

# ===========================
# 🔗 Aliases - Sistema
# ===========================
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rns'
alias installu='sudo pacman -U'
alias update='sudo pacman -Syu'

# ===========================
# 🔗 Aliases - Navegación básica
# ===========================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='lsd'
alias ll='lsd -lh'
alias la='lsd -A'
alias lsa='lsd -lah'
alias lss='lsd -lh'
alias gc="git clone"
alias v="nvim"
alias zshconf="$EDITOR ~/.zshrc && source ~/.zshrc"

# ===========================
# 🔗 Aliases - Rutas Biglex J
# ===========================
alias bj='cd /mnt/ntfs/'
alias bjd='/mnt/ntfs/Descargas'
alias bje='/mnt/ntfs/Documentos'
alias bji='/mnt/ntfs/Imágenes'
alias bjm='/mnt/ntfs/Música'
alias bjv='/mnt/ntfs/Videos'

# ===========================
# 🛠️ Git Shortcuts
# ===========================
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# ===========================
# 🚀 Node/NPM/PNPM
# ===========================
alias dev='pnpm run dev'
alias build='pnpm run build'
alias start='pnpm start'
alias pni='pnpm install'
alias pnr='pnpm run'

# ===========================
# 🎮 Funciones de Utilidad
# ===========================
function mkcd {
    mkdir -p "$1" && cd "$1"
}

function extract {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' no se puede extraer" ;;
        esac
    else
        echo "'$1' no es un archivo válido"
    fi
}

# Mostrar todos los aliases disponibles
function show_aliases {
    echo -e "\n\033[0;33m🔗 Aliases de Navegación:\033[0m"
    echo -e "  \033[0;37m.., ..., ....  → Subir directorios\033[0m"
    echo -e "  \033[0;37mbj             → /mnt/ntfs (raíz)\033[0m"
    echo -e "  \033[0;37mbjd            → Descargas\033[0m"
    echo -e "  \033[0;37mbje            → Documentos\033[0m"
    echo -e "  \033[0;37mbji            → Imágenes\033[0m"
    echo -e "  \033[0;37mbjm            → Música\033[0m"
    echo -e "  \033[0;37mbjv            → Videos\033[0m"
    
    echo -e "\n\033[0;33m🛠️  Git Shortcuts:\033[0m"
    echo -e "  \033[0;37mgs   → git status\033[0m"
    echo -e "  \033[0;37mga   → git add\033[0m"
    echo -e "  \033[0;37mgc   → git commit -m\033[0m"
    echo -e "  \033[0;37mgp   → git push\033[0m"
    echo -e "  \033[0;37mgpl  → git pull\033[0m"
    
    echo -e "\n\033[0;33m🚀 Desarrollo:\033[0m"
    echo -e "  \033[0;37mdev    → pnpm run dev\033[0m"
    echo -e "  \033[0;37mbuild  → pnpm run build\033[0m"
    echo -e "  \033[0;37mpni    → pnpm install\033[0m"
    
    echo -e "\n\033[0;33m📦 Sistema:\033[0m"
    echo -e "  \033[0;37minstall    → sudo pacman -S\033[0m"
    echo -e "  \033[0;37muninstall  → sudo pacman -Rns\033[0m"
    echo -e "  \033[0;37mupdate     → sudo pacman -Syu\033[0m"
    
    echo -e "\n\033[0;33m🔧 Scripts:\033[0m"
    echo -e "  \033[0;37mmountdisk  → Montar disco\033[0m"
    echo -e "  \033[0;37mscrcpycn   → Conectar scrcpy\033[0m"
    
    echo -e "\n\033[0;36m💡 Tip: Escribe 'help' o 'aliases' para ver esta ayuda\n\033[0m"
}

alias help='show_aliases'
alias aliases='show_aliases'

# ===========================
# 🌍 Variables de Entorno
# ===========================

# Flutter
export PATH="$PATH:/opt/Dev-Tools/SDK/Flutter/bin/"

# Java
export JAVA_HOME="/opt/Dev-Tools/JDK/Java/jdk-21.0.7+6/"
export PATH="$PATH:$JAVA_HOME/bin"

# Gradle
export PATH="$PATH:/opt/Dev-Tools/Build-Tools/Gradle/gradle-8.14.1/bin/"

# Android SDK
export ANDROID_SDK_ROOT="/opt/Dev-Tools/SDK/Android/"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/build-tools/34.0.0"
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"

# NVIDIA (para GPU)
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0

# Rust/Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Microsoft Edge
export PATH="$PATH:/opt/microsoft/msedge/"

# Brave
alias brave='brave --password-store=basic'

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Completions
fpath=(~/.zsh/completions $fpath)

# ===========================
# 🔧 Scripts personalizados
# ===========================
alias mountdisk='/mnt/files/Instaladores/Linux/Instrucciones/Scripts/mount.sh'
alias scrcpycn='/mnt/files/Instaladores/Linux/Instrucciones/Scripts/scrcpy-connect.sh'

# ===========================
# 🎉 Mostrar Banner al iniciar
# ===========================
clear
show_banner
echo ""
show_system_info
echo ""
echo -e "\033[0;32m🎉 ¡Terminal de Biglex J cargada exitosamente!\033[0m"
echo -e "\033[0;36m💡 Escribe 'help' para ver todos los comandos disponibles\033[0m"
echo -e "\033[0;35m🚀 ¡A programar y crear contenido épico!\033[0m"
echo ""