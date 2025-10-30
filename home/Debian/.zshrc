# ===========================
# 🚀 .zshrc - Biglex J Edition (Debian/WSL)
# ===========================

export ZSH="$HOME/.oh-my-zsh"
ENABLE_CORRECTION="true"

# ===========================
# 🎨 Prompt personalizado
# ===========================
PROMPT='%F{red} %f %F{#45a5ff}%B%n%f%b $(dir_icon) %F{white}%B%1~%f%${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{#25d594}» .%F{red}»)%f%b'

# ===========================
# 🔌 Plugins
# ===========================
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
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
function dir_icon {
    if [[ "$PWD" == "$HOME" ]]; then
        echo "%B%F{#FF4C70}%f%b"
    else
        echo "%B%F{#45a5ff}%f%b"
    fi
}

function parse_git_branch {
    local branch
    branch=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ -n "$branch" ]; then
        echo " [$branch]"
    fi
}

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
    echo -e "${color}║           WSL/Debian Edition • Build: CREATOR-EDITION           ║${reset}"
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
    local os_info=$(lsb_release -ds 2>/dev/null || echo "Debian/WSL")
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
alias install='sudo apt install'
alias updateup='sudo apt update && sudo apt upgrade -y'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade -y'
alias clean='sudo apt autoremove && sudo apt autoclean'

# ===========================
# 🔗 Aliases - Navegación básica
# ===========================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -lh'
alias ls='lsd'
alias la='lsd -a'
alias lsa='ls -lah --color=auto'
alias lss='ls -lh --color=auto'

# ===========================
# 🔗 Aliases - Rutas Biglex J (WSL)
# ===========================
# Raíz de montaje Windows
alias bj='cd /mnt/e'

# Carpetas principales (Drive E:)
alias bjdes='cd /mnt/e/Descargas'
alias bjdoc='cd /mnt/e/Documentos'
alias bjimg='cd /mnt/e/Imágenes'
alias bjmus='cd /mnt/e/Música'
alias bjvid='cd /mnt/e/Videos'

# Carpetas de desarrollo
alias bjpro='cd /mnt/e/Proyectos'
alias bjpros='cd /mnt/e/Proyectos/biglexj'
alias bjass='cd /mnt/e/Assets'

# Carpetas de contenido
alias bjdav='cd /mnt/e/Videos/DaVinci\ Resolve'
alias bjyt='cd /mnt/e/Imágenes/YouTube'
alias bjmarca='cd /mnt/e/Imágenes/Proyectos/Marca'

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
    echo -e "  \033[0;37mbj             → /mnt/e (raíz Windows)\033[0m"
    echo -e "  \033[0;37mbjpro          → Proyectos\033[0m"
    echo -e "  \033[0;37mbjpros         → Proyectos/biglexj\033[0m"
    echo -e "  \033[0;37mbjyt           → YouTube assets\033[0m"
    echo -e "  \033[0;37mbjdav          → DaVinci Resolve\033[0m"
    
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
    
    echo -e "\n\033[0;36m💡 Tip: Escribe 'help' o 'aliases' para ver esta ayuda\n\033[0m"
}

alias help='show_aliases'
alias aliases='show_aliases'

# ===========================
# 🌍 Variables de Entorno
# ===========================

# Flutter
export PATH="$PATH:$HOME/Dev-Tools/SDK/Flutter/bin/"

# Java
export JAVA_HOME="$HOME/Dev-Tools/JDK/Java/jdk-23.0.1+11/"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH=$PATH:$HOME/Dev-Tools/Build-Tools/Gradle/gradle-8.10.2/bin/

# Android
export ANDROID_SDK_ROOT=$HOME/Dev-Tools/SDK/Android/
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/34.0.0
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

# NVIDIA (para WSL con GPU)
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0

# Rust/Cargo
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Brave
alias brave='brave --password-store=basic'

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Supabase (supa-images)
export SUPABASE_URL="https://rjtvzejsfjnvedforugq.supabase.co"
export SUPABASE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJqdHZ6ZWpzZmpudmVkZm9ydWdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNjA0NDQsImV4cCI6MjA3NDczNjQ0NH0.qkclyPzPPLDucYmRgqdA8lK593wLr67WtsiwDbhFScA"
alias supa-images='curl "$SUPABASE_URL/rest/v1/images" \
  -H "apikey: $SUPABASE_KEY" \
  -H "Authorization: Bearer $SUPABASE_KEY"'

# ===========================
# 🎉 Mostrar Banner al iniciar
# ===========================
clear
show_banner
echo ""
show_system_info
echo ""
echo -e "\033[0;32m🎉 ¡Terminal de Biglex J cargado exitosamente!\033[0m"
echo -e "\033[0;36m💡 Escribe 'help' para ver todos los comandos disponibles\033[0m"
echo -e "\033[0;35m🚀 ¡A programar y crear contenido épico!\033[0m"
echo ""
