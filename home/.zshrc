# Configuración de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Corrección automática
ENABLE_CORRECTION="true"

# Tema vacío (personalizado)
ZSH_THEME=""

setopt prompt_subst
# Funciones personalizadas
function dir_icon {
    if [[ "$PWD" == "$HOME" ]]; then
        # Home
        echo "%{%B%F{white}%}%{%f%b%}"
    else
        # Carpeta
        echo "%{%B%F{cyan}%}%{%f%b%}"
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

# PROMPT personalizado (corregido)
PROMPT='%f %F{#45a5ff}%B%n%f%b $(dir_icon) %F{white}%B%1~%f%${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{#25d594}» .%F{red}»)%f%b'

# Add zsh-completions to fpath
fpath=(${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src $fpath)

# Plugins# Plugins
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

# Colores de resaltado de sintaxis
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF4C70,bold'     # Color general
ZSH_HIGHLIGHT_STYLES[bad-command]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#00AAFF,bold'
ZSH_HIGHLIGHT_STYLES[command]=fg=#00F5CE,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=#00F5CE,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#00F5CE,bold

# Deshabilitar colores en ls
unset LS_COLORS
export LS_COLORS=""

# Alias
# Alias
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rns'
alias installu='sudo pacman -U'
alias upd='sudo pacman -Syu'
alias par='paru'
alias pi='paru -S'
alias pu='paru -Rns'
alias parui='paru -S'
alias paruuninst='paru -Rns'
alias yi='yay -S'
alias yu='yay -Rns'
alias yayi='yay -S'
alias yayuninst='yay -Rns'
alias y='yay'
alias ..='cd ..'
alias ls='lsd'
alias ll='lsd -lh'
alias la='lsd -A'
alias lsa='lsd -lah'
alias lss='lsd -lh'
alias gc="git clone"
alias v="nvim"
alias zshconf="$EDITOR ~/.zshrc && source ~/.zshrc"

# ===========================
# 🔗 Aliases de navegación rápida (Biglex J)
# ===========================
export BASE_DRIVE="/mnt/ntfs"

alias ...="cd ../.."
alias ....="cd ../../.."

alias bjpro="cd $BASE_DRIVE/Proyectos"
alias bjpros="cd $BASE_DRIVE/Proyectos/biglexj"
alias bjdes="cd $BASE_DRIVE/Descargas"
alias bjdoc="cd $BASE_DRIVE/Documentos"
alias bjimg="cd $BASE_DRIVE/Imágenes"
alias bjmus="cd $BASE_DRIVE/Música"
alias bjvid="cd $BASE_DRIVE/Videos"
alias bjass="cd $BASE_DRIVE/Assets"
alias bjdav="cd $BASE_DRIVE/Videos/DaVinci\ Resolve"
alias bjyt="cd $BASE_DRIVE/Imágenes/YouTube"
alias bjmarca="cd $BASE_DRIVE/Imágenes/Proyectos/Marca"
alias docs="cd $BASE_DRIVE/Proyectos/biglexj/Docs"
# alias aurora="cd /var/www/aurora-blog"  # reemplazado por función aurora() en bloque AURORA MANAGED

# ===========================
# 🎨 Banner ASCII de bienvenida
# ===========================
function print_banner() {
    local banner=(
"╔═════════════════════════════════════════════════════════════════╗"
"║                                                                 ║"
"║      ██████╗ ██╗ ██████╗ ██╗     ███████╗██╗  ██╗      ██╗      ║"
"║      ██╔══██╗██║██╔════╝ ██║     ██╔════╝╚██╗██╔╝      ██║      ║"
"║      ██████╔╝██║██║  ███╗██║     █████╗   ╚███╔╝       ██║      ║"
"║      ██╔══██╗██║██║   ██║██║     ██╔══╝   ██╔██╗       ██║      ║"
"║      ██████╔╝██║╚██████╔╝███████╗███████╗██╔╝ ██╗   ██╗██║      ║"
"║      ╚═════╝ ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝╚═╝      ║"
"║                                                                 ║"
"║              W E L C O M E   T O   B I G L E X - J              ║"
"║                                                                 ║"
"║           CLI Version 2.0.0 • Build: CREATOR-EDITION            ║"
"║                                                                 ║"
"║   🎨 Content Creator | 💻 Developer | 🎵 JPop Enthusiast        ║"
"║   🚀 C# • React • Python | 🎬 DaVinci • Blender • OBS           ║"
"║                                                                 ║"
"║              > Ready to create amazing content...               ║"
"║                                                                 ║"
"╚═════════════════════════════════════════════════════════════════╝"
    )

    local colors=('\e[36m' '\e[35m' '\e[33m' '\e[32m' '\e[34m' '\e[31m')
    local primary_color="${colors[$((RANDOM % ${#colors[@]} + 1))]}"
    
    for line in "${banner[@]}"; do
        echo -e "${primary_color}${line}\e[0m"
    done
}

# ===========================
# ℹ️ Info del sistema
# ===========================
function show_system_info_table() {
    local os=$(uname -snr)
    local host_name=$(hostname)
    local user_name=$(whoami)
    local up_time=$(uptime -p 2>/dev/null || uptime | awk '{print $3}' | tr -d ',')
    local current_date=$(date '+%d/%m/%Y %H:%M')
    local shell_ver="v$ZSH_VERSION"

    local colors=('\e[32m' '\e[33m' '\e[35m' '\e[34m' '\e[36m' '\e[31m')
    local border_color="${colors[1]}"
    local reset='\e[0m'
    
    echo -e "${border_color}┌─────────────────────────────────────────────────────────────────┐${reset}"
    
    local labels=(" S.O" " Equipo" " Usuario" " Uptime" " Fecha" " ZSH")
    local values=("$os" "$host_name" "$user_name" "$up_time" "$current_date" "$shell_ver")
    
    for i in {1..6}; do
        local color="${colors[$(((i-1) % ${#colors[@]} + 1))]}"
        printf "${border_color}│${reset}${color}%-18s${reset} | ${color}%-42s${reset}  ${border_color}│${reset}\n" "${labels[$i]}" "${values[$i]}"
    done

    echo -e "${border_color}└─────────────────────────────────────────────────────────────────┘${reset}"
}

print_banner
show_system_info_table

# ===========================
# 🛠️ Utilidades de desarrollo
# ===========================
function touch_file() {
    if [[ ! -e "$1" ]]; then
        command touch "$1"
        echo -e "\e[32m✅ Archivo creado: $1\e[0m"
    else
        command touch "$1"
        echo -e "\e[33m🔄 Archivo actualizado: $1\e[0m"
    fi
}
alias touch="touch_file"

function gs() { 
    git status
    echo -e "\e[36m📊 Estado del repositorio mostrado\e[0m"
}

function ga() { 
    git add "${1:-.}"
    echo -e "\e[32m➕ Archivos agregados al staging\e[0m"
}

function gcm() { 
    if [[ -n "$1" ]]; then
        git commit -m "$1"
        echo -e "\e[32m💾 Commit realizado: $1\e[0m"
    else
        echo -e "\e[31m❌ Necesitas un mensaje de commit\e[0m"
    fi
}

function gp() { 
    git push
    echo -e "\e[32m🚀 Cambios enviados al repositorio remoto\e[0m"
}

function gpl() { 
    git pull
    echo -e "\e[34m⬇️  Cambios descargados del repositorio remoto\e[0m"
}

alias dev="bun run dev"
alias build="bun run build"
alias start="bun start"

# ===========================
# 🤖 Ely Intelligence & Live Stream
# ===========================
alias ely-intelligence="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_ely_core.ps1"
alias live="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_live.ps1"
alias vozely="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_voz_ely.ps1"
alias voice-ely="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_ely_voice_pipeline.ps1"

function add-video() {
    pwsh "$BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/add-video.ps1" -Url "$1" -Type "video" -Title "$2" -Description "$3"
}

function add-karaoke() {
    pwsh "$BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/add-video.ps1" -Url "$1" -Type "karaoke" -Title "$2" -Description "$3" -Tags "$4"
}

# ===========================
# 🎬 PRODUCCIÓN DE CONTENIDO
# ===========================
function new-project() {
    echo -e "\e[36m\n╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[36m║           🎬 CREAR NUEVO PROYECTO DE VIDEO                     ║\e[0m"
    echo -e "\e[36m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    
    echo -e "\e[33m📺 Selecciona el canal:\e[0m"
    echo -e "\e[90m  1) @biglexj\e[0m"
    echo -e "\e[90m  2) @ely-vtuber\e[0m"
    echo -e "\e[90m  3) @biglexjtema\e[0m"
    echo -e "\e[90m  4) @biglexlive\e[0m"
    echo -e "\e[90m  5) @biglexpe\e[0m"
    
    read "canalOption?Opción: "
    
    local canal=""
    case $canalOption in
        1) canal="@biglexj" ;;
        2) canal="@ely-vtuber" ;;
        3) canal="@biglexjtema" ;;
        4) canal="@biglexlive" ;;
        5) canal="@biglexpe" ;;
        *) echo -e "\e[31m❌ Opción inválida\e[0m"; return 1 ;;
    esac
    
    echo -e "\e[33m\n🎥 Tipo de video:\e[0m"
    echo -e "\e[90m  1) Video normal\e[0m"
    echo -e "\e[90m  2) Short\e[0m"
    
    read "tipoOption?Opción: "
    
    local path_base="$BASE_DRIVE/Videos/DaVinci Resolve/$canal"
    
    if [[ "$tipoOption" == "2" ]]; then
        path_base="$path_base/Shorts"
    fi
    
    if [[ ! -d "$path_base" ]]; then
        echo -e "\e[31m❌ La carpeta del canal no existe: $path_base\e[0m"
        return 1
    fi
    
    local lastNumber=0
    for dir in "$path_base"/[0-9]*.(/); do
        if [[ -d "$dir" ]]; then
            local num=$(basename "$dir" | grep -Eo '^[0-9]+')
            if [[ -n "$num" ]] && (( num > lastNumber )); then
                lastNumber=$num
            fi
        fi
    done
    
    local newNumber=$((lastNumber + 1))
    echo -e "\e[32m\n📝 Número asignado: $newNumber\e[0m"
    
    read "titulo?📌 Título del video: "
    
    if [[ -z "$titulo" ]]; then
        echo -e "\e[31m❌ El título no puede estar vacío\e[0m"
        return 1
    fi
    
    local projectPath="$path_base/$newNumber. $titulo"
    
    if mkdir -p "$projectPath/Imágenes" "$projectPath/Videos" "$projectPath/Audio"; then
        echo -e "\e[32m\n✅ ¡Proyecto creado exitosamente!\e[0m"
        echo -e "\e[36m📁 Ruta: $projectPath\e[0m"
    else
        echo -e "\e[31m\n❌ Error al crear el proyecto.\e[0m"
    fi
}

# ===========================
# 🎨 UTILIDADES CREATIVAS
# ===========================
function color-palette() {
    echo -e "\n\e[36m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[36m║              🎨 PALETA OFICIAL BIGLEX J                        ║\e[0m"
    echo -e "\e[36m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    echo -e "\e[90m┌────────────┬────────────┬────────────┬────────────┐\e[0m"
    echo -e "\e[90m│  \e[0m\e[36m████████\e[0m\e[90m  │  \e[0m\e[31m████████\e[0m\e[90m  │  \e[0m\e[32m████████\e[0m\e[90m  │  \e[0m\e[34m████████\e[0m\e[90m  │\e[0m"
    echo -e "\e[90m│  \e[0m#00AAFF   \e[90m│  \e[0m#FF6B4C   \e[90m│  \e[0m#4CFF5B   \e[90m│  \e[0m#5B4CFF   \e[90m│\e[0m"
    echo -e "\e[90m│  \e[90mCyan Base \e[90m│  \e[90mCoral     \e[90m│  \e[90mVerde     \e[90m│  \e[90mMorado    \e[90m│\e[0m"
    echo -e "\e[90m└────────────┴────────────┴────────────┴────────────┘\e[0m"
    
    echo -e "\n\e[35m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[35m║             🎨 PALETA OFICIAL ELY VTUBER                       ║\e[0m"
    echo -e "\e[35m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    echo -e "\e[90m┌────────────┬────────────┬────────────┬────────────┐\e[0m"
    echo -e "\e[90m│  \e[0m\e[36m████████\e[0m\e[90m  │  \e[0m\e[35m████████\e[0m\e[90m  │  \e[0m\e[90m████████\e[0m\e[90m  │  \e[0m\e[33m████████\e[0m\e[90m  │\e[0m"
    echo -e "\e[90m│  \e[0m#00C7B1   \e[90m│  \e[0m#FB7793   \e[90m│  \e[0m#6E7179   \e[90m│  \e[0m#FFE6CA   \e[90m│\e[0m"
    echo -e "\e[90m│  \e[90mTurquesa  \e[90m│  \e[90mRosa      \e[90m│  \e[90mGris Polo \e[90m│  \e[90mBeige     \e[90m│\e[0m"
    echo -e "\e[90m└────────────┴────────────┴────────────┴────────────┘\e[0m"
}

function bgm() {
    local bgmPath="$BASE_DRIVE/Música/IA Sounds/Instrumental 2"
    if [[ -d "$bgmPath" ]]; then
        xdg-open "$bgmPath" &>/dev/null || open "$bgmPath" &>/dev/null
        echo -e "\e[36m🎵 Biblioteca de música de fondo abierta\e[0m"
    else
        echo -e "\e[31m❌ No se encontró la carpeta de música de fondo\e[0m"
    fi
}

# ===========================
# 🌐 WEB & REDES
# ===========================
function open-biglexj() {
    xdg-open "https://biglexj.com" &>/dev/null
    echo -e "\e[36m🌐 Abriendo biglexj.com...\e[0m"
}

function open-youtube() {
    xdg-open "https://studio.youtube.com" &>/dev/null
    echo -e "\e[31m📺 Abriendo YouTube Studio...\e[0m"
}

# ===========================
# ⚙️ SISTEMA Y MANTENIMIENTO
# ===========================
function check-space() {
    echo -e "\n\e[33m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[33m║              💾 ESPACIO EN DISCOS                              ║\e[0m"
    echo -e "\e[33m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    df -h | grep -v 'loop'
}

function update-profile() {
    source ~/.zshrc
    echo -e "\e[32m✅ Configuración de ZSH recargada\e[0m"
}

function edit-profile() {
    $EDITOR ~/.zshrc
}

# ===========================
# 📚 Sistema de Ayuda Mejorado
# ===========================
function help() {
    echo -e "\n\e[36m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[36m║               📚 AYUDA DE COMANDOS - BIGLEX J (ZSH)            ║\e[0m"
    echo -e "\e[36m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    
    echo -e "\e[33m🔗 NAVEGACIÓN RÁPIDA\e[0m"
    echo -e "\e[90m  ..           → Subir un directorio\e[0m"
    echo -e "\e[90m  ...          → Subir dos directorios\e[0m"
    echo -e "\e[90m  aurora       → Ir al proyecto Aurora Blog (/var/www/aurora-blog)\e[0m"
    echo -e "\e[90m  bjpro        → Ir a D:\\Proyectos (en Windows/WSL)\e[0m"
    echo -e "\e[90m  bjpros       → Ir a D:\\Proyectos\\biglexj (en Windows/WSL)\e[0m"
    echo -e "\e[90m  docs         → Abrir documentación\e[0m"
    
    echo -e "\e[33m\n🛠️  DESARROLLO (Git & Zsh)\e[0m"
    echo -e "\e[90m  gs           → git status\e[0m"
    echo -e "\e[90m  ga [arch]    → git add [archivos]\e[0m"
    echo -e "\e[90m  gcm 'msg'    → git commit -m 'msg'\e[0m"
    echo -e "\e[90m  gp           → git push\e[0m"
    echo -e "\e[90m  gpl          → git pull\e[0m"
    
    echo -e "\e[33m\n🤖 AURORA SERVER (Linux) — 7 servicios PM2\e[0m"
    echo -e "\e[90m  aurora        → Ir al proyecto Aurora Blog (/var/www/aurora-blog)\e[0m"
    echo -e "\e[90m  aurora-build  → Compilar servicios (all|backend|live|voice|aicore|ely-core)\e[0m"
    echo -e "\e[90m  aurora-start  → Iniciar servicios (all|core|live|voice|ely|ely-core)\e[0m"
    echo -e "\e[90m  aurora-stop   → Detener servicios (all|...)\e[0m"
    echo -e "\e[90m  aurora-restart→ Reiniciar servicios (stop + start)\e[0m"
    echo -e "\e[90m  aurora-check  → Monitorear puertos y procesos de Aurora\e[0m"
    echo -e "\e[90m  aurora-pull   → git pull + reinstalar deps + reiniciar servicios\e[0m"
    echo -e "\e[90m  aurora logs   → Ver logs PM2 (sin args = todos; ej: aurora logs voice)\e[0m"
    
    echo -e "\e[33m\n🎨 CREATIVIDAD & WEB\e[0m"
    echo -e "\e[90m  color-palette → Mostrar paleta de colores oficial (Biglex J & Ely)\e[0m"
    echo -e "\e[90m  open-biglexj  → Abrir biglexj.com\e[0m"
    
    echo -e "\e[33m\n⚙️  SISTEMA\e[0m"
    echo -e "\e[90m  system-info   → Mostrar información del sistema (fastfetch)\e[0m"
    echo -e "\e[90m  check-space   → Ver espacio en disco\e[0m"
    echo -e "\e[90m  edit-profile  → Editar configuración .zshrc\e[0m"
    
    echo -e "\n\e[36m💡 Tip: Escribe 'aliases' para ver la lista compacta\e[0m\n"
}

function aliases() {
    echo -e "\n\e[35m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[35m║                🔗 ALIASES DISPONIBLES - LINUX                  ║\e[0m"
    echo -e "\e[35m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    
    echo -e "\e[33m>> NAVEGACIÓN\e[0m"
    echo -e "\e[90m  .., ..., aurora, docs, bjpro, bjpros, bjdes, bjdoc, bjimg, bjmus, bjvid\e[0m"
    
    echo -e "\e[33m\n>> GIT & DEV\e[0m"
    echo -e "\e[90m  gs, ga, gcm, gp, gpl, dev, build, start, clonar, renombrar\e[0m"
    
    echo -e "\e[33m\n>> AURORA SERVER\e[0m"
    echo -e "\e[90m  aurora, aurora-build, aurora-start, aurora-stop, aurora-restart, aurora-check, aurora-pull, aurora logs\e[0m"
    
    echo -e "\e[33m\n>> SISTEMA & CREATIVIDAD\e[0m"
    echo -e "\e[90m  system-info, check-space, edit-profile, color-palette, open-biglexj\e[0m"
    
    echo -e "\e[36m\n💡 Tip: Escribe 'help' para ver descripciones detalladas\e[0m\n"
}
# ===========================
# 📁 SCRIPTS
# ===========================
alias screaming="pwsh $BASE_DRIVE/Proyectos/biglexj/Scripts/Estructure/setup-screaming-architecture.ps1"
function clonar() { python3 "$BASE_DRIVE/Proyectos/biglexj/Scripts/clonar_estructura.py" "$@"; }
function renombrar() { python3 "$BASE_DRIVE/Proyectos/biglexj/Scripts/renombrar_archivos_carpetas.py" "$@"; }

# ===========================
# 🌟 Mensaje de bienvenida final
# ===========================
echo -e "\n\e[32m🎉 ¡Terminal de Biglex J cargado exitosamente!\e[0m"
echo -e "\e[34m💡 Escribe 'help' para ver todos los comandos disponibles\e[0m"
echo -e "\e[36m📌 Escribe 'aliases' para ver solo la lista de comandos\e[0m"
echo -e "\e[35m🚀 ¡A programar y crear contenido épico!\e[0m\n"

# Path
export PATH=$PATH:/opt/Dev-Tools/SDK/Flutter/bin/
export JAVA_HOME=/opt/Dev-Tools/JDK/Java/jdk-21.0.7+6/
export PATH=$PATH:/opt/Dev-Tools/Build-Tools/Gradle/gradle-8.14.1/bin/
export ANDROID_SDK_ROOT=/opt/Dev-Tools/SDK/Android/
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/34.0.0
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias brave='brave --password-store=basic'

# Alias a Scripts
alias mountdisk='/mnt/files/Instaladores/Linux/Instrucciones/Scripts/mount.sh'
alias scrcpycn='/mnt/files/Instaladores/Linux/Instrucciones/Scripts/scrcpy-connect.sh'
export PATH=$PATH:/opt/microsoft/msedge/
fpath=(~/.zsh/completions $fpath)

export PATH=/home/biglexj/.opencode/bin:$PATH

# ==============================================================================
# 🖥️ ALIASES DE GESTIÓN DEL ENTORNO GRÁFICO Y RUSTDESK (Hyprland / Headless Server)
# ==============================================================================
alias guion='sudo systemctl start display-manager && sleep 2 && sudo systemctl restart rustdesk'
alias guioff='sudo systemctl stop display-manager && sudo systemctl stop rustdesk'
alias gui-start='sudo systemctl start display-manager && sleep 2 && sudo systemctl restart rustdesk'
alias gui-stop='sudo systemctl stop display-manager && sudo systemctl stop rustdesk'

# Aliases cortos para RustDesk
alias rdon='sudo systemctl restart rustdesk'
alias rdoff='sudo systemctl stop rustdesk'
alias rdstatus='systemctl status rustdesk'


export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet

# bun completions
[ -s "/home/biglexj/.bun/_bun" ] && source "/home/biglexj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# (aliases sueltos 'aurora' y 'check-aurora' eliminados — ahora gestionados por bloque AURORA MANAGED)




# === AURORA MANAGED ALIASES ===
# Generado por setup-linux-aliases.sh — NO editar manualmente

AURORA_ROOT="/var/www/aurora-blog"
AURORA_SCRIPTS="$AURORA_ROOT/scripts/server"

# Check: ver estado de servicios (local en el servidor)
alias aurora-check="bun run $AURORA_ROOT/scripts/check-services.ts"

# Pull: git pull (con --restart para reiniciar servicios)
alias aurora-pull="bash $AURORA_SCRIPTS/aurora-pull.sh"

# Start / Stop / Build / Restart servicios (con guion, forma clásica)
alias aurora-start="bash $AURORA_SCRIPTS/aurora-start.sh"
alias aurora-stop="bash $AURORA_SCRIPTS/aurora-stop.sh"
alias aurora-build="bash $AURORA_SCRIPTS/aurora-build.sh"
alias aurora-restart="bash $AURORA_SCRIPTS/aurora-restart.sh"

# Despachador principal: aurora <subcomando> [args]
# Subcomandos: build | start | stop | restart | check | pull | cd | logs
function aurora() {
    local cmd="$1"
    if [ -z "$cmd" ]; then
        cd "$AURORA_ROOT"
        return
    fi
    shift
    case "$cmd" in
        build)        bash "$AURORA_SCRIPTS/aurora-build.sh" "$@" ;;
        start)        bash "$AURORA_SCRIPTS/aurora-start.sh" "$@" ;;
        stop)         bash "$AURORA_SCRIPTS/aurora-stop.sh" "$@" ;;
        restart)      bash "$AURORA_SCRIPTS/aurora-restart.sh" "$@" ;;
        check|status) bun run "$AURORA_ROOT/scripts/check-services.ts" ;;
        pull)         bash "$AURORA_SCRIPTS/aurora-pull.sh" "$@" ;;
        cd|goto)      cd "$AURORA_ROOT" ;;
        logs)         bash "$AURORA_SCRIPTS/aurora-logs.sh" "$@" ;;
        help|-h|--help)
            echo ""
            echo "🛠️  Aurora CLI — Gestión del ecosistema de servicios"
            echo ""
            echo "USO: aurora <comando> [target]"
            echo ""
            echo "COMANDOS:"
            echo "  aurora                   → cd al proyecto"
            echo "  aurora build   TARGET    → Compilar servicios"
            echo "  aurora start   TARGET    → Iniciar servicios"
            echo "  aurora stop    TARGET    → Detener servicios"
            echo "  aurora restart TARGET    → Reiniciar (stop + start)"
            echo "  aurora check             → Ver estado de todos los servicios"
            echo "  aurora logs    [svc]     → Ver logs (pm2 o archivos)"
            echo "  aurora pull    [--restart] → git pull + reinstalar deps"
            echo ""
            echo "TARGETS (build):  all | backend | live | live-chat | voice | aicore | ely-core"
            echo "TARGETS (start):  all | astro | core | live | voz | voice | ely | ely-core | intelligence"
            echo ""
            echo "EJEMPLOS:"
            echo "  aurora build voice,aicore    → Compilar solo Voice + AICore"
            echo "  aurora start all             → Iniciar todos los backends"
            echo "  aurora restart ely-core      → Reiniciar solo ElyCore"
            echo "  aurora logs voice            → Ver logs del servicio Voice"
            echo "  aurora pull --restart        → Pull + reinstalar + reiniciar"
            echo ""
            echo "ALIASES DIRECTOS (con guion):"
            echo "  aurora-build, aurora-start, aurora-stop, aurora-restart,"
            echo "  aurora-check, aurora-pull"
            ;;
        *)
            echo "Comando desconocido: $cmd (usa 'aurora help')" >&2
            return 1
            ;;
    esac
}
# === END AURORA MANAGED ALIASES ===

# ==============================================================================
# 🖥️ KDE INIT — Inicia KDE Plasma bajo demanda (vía SDDM + autologin)
# ==============================================================================
# Por defecto el sistema arranca en TTY (multi-user.target). El comando
# 'kde-init' inicia SDDM, que tiene autologin -> plasma en /etc/sddm.conf.
# Para Hyprland, sigue usando 'Hyprland' directo desde TTY1 como siempre.
if [ -x "$HOME/.local/bin/kde-init" ]; then
    alias kde='kde-init start'
    alias kde-stop='kde-init stop'
    alias kde-status='kde-init status'
    alias gui-kde='kde-init start'
fi
# === END KDE INIT ===
